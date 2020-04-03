<template>
    <section id="result" class="content">
        <div v-show="isStart" class="box is-primary has-text-centered result-box -start"><i class="fas fa-dna"></i>Let's search Taxonomy entries!</div>
        <div v-show="isLoading" class="box is-info has-text-centered result-box -search"><i class="fas fa-spinner fa-spin"></i>Now searching...</div>
        <div v-show="isError" class="box is-warning has-text-centered result-box -error"><i class="fas fa-sad-tear"></i>Sorry caused an error...</div>
        <div v-show="!isStart & !isLoading & !isError" class="search_loaded">
            <div class="box is-primary result-box -result">
                <p>terms : <span>{{ tx_taxonomy_id }} {{ scientific_name }}</span> <a class="button is-info toDetail" :href="toBilsampleLink"><i class="fas fa-external-link-alt"></i>Show all Taxonomies</a></p>
                <p>Parents : Total <span>{{ parentTotal }}</span> records</p>
                <p>Children : Total <span>{{ childTotal }}</span> records / <span>{{ per_page }}</span> records / Sort by <span>{{ sort_key }}</span> / Order <span> {{ order_by }}</span> / Page no. <span>{{ page_no }}</span></p>
            </div>

            <p class="title is-5">Parents</p>
            <b-table
                    :data="parentData"
                    ref="table"
                    hoverable
                    class="mb-3">

                <template slot-scope="props">
                    <b-table-column field="TaxonomyID" label="Taxonomy ID" sortable>
                        <template>
                            <router-link :to="{ name: 'taxonomy', query:{ tx_taxonomy_id: props.row.taxid } }">{{ props.row.taxid }}</router-link>
                        </template>
                    </b-table-column>
                    <b-table-column field="ScientificName" label="Scientific Name">{{ props.row.label }}</b-table-column>
                </template>
            </b-table>

            <p class="title is-5">Children</p>
            <b-table
                    :data="childData"
                    ref="table"
                    hoverable
                    class="mb-3"

                    backend-sorting
                    :default-sort="[sort_key, order_by]"
                    @sort="onSort"

                    paginated
                    backend-pagination
                    @page-change="onPageChange"
                    :total="childTotal"
                    :per-page="per_page">

                <template slot-scope="props">
                    <b-table-column field="TaxonomyID" label="Taxonomy ID" sortable>
                        <template>
                            <router-link :to="{ name: 'taxonomy', query:{ tx_taxonomy_id: props.row.taxid } }">{{ props.row.taxid }}</router-link>
                        </template>
                    </b-table-column>
                    <b-table-column field="ScientificName" label="Scientific Name" sortable>{{ props.row.label }}</b-table-column>
                </template>
            </b-table>


            <div v-show="isDendrogramLoading" class="box is-info has-text-centered result-box -search"><i class="fas fa-spinner fa-spin"></i>Now dendrogram drawing...</div>
            <div v-show="isDendrogramError" class="box is-warning has-text-centered result-box -error"><i class="fas fa-sad-tear"></i>Sorry caused an error to dendrogram drawing...</div>
            <div v-show="!isStart & !isDendrogramLoading & !isDendrogramError & targetTaxId !== '' & targetName !== ''" class="search_loaded">
                <div class="box is-primary result-box -result has-text-centered">
                    <p>Taxonomy ID : <span>{{ targetTaxId }}</span> Scientific Name : <span>{{ targetName }}</span></p>
                </div>
            </div>
<!--
            <script src="https://cdn.jsdelivr.net/combine/npm/@babel/polyfill@7.2.5/dist/polyfill.min.js,npm/@ungap/url-search-params@0.1.2/min.js,npm/whatwg-fetch@3.0.0/dist/fetch.umd.js" crossorigin></script>
            <script src="https://cdn.jsdelivr.net/npm/@webcomponents/webcomponentsjs@1.3.0/webcomponents-loader.js" crossorigin></script>
            <link rel="import" href="http://togostanza.org/dist/metastanza/dendrogram/">
            <link rel="stylesheet" href="http://togostanza.org/dist/metastanza/assets/css/ts.css">
            <div id="contents">
                <div class="showcase_detail">
                    <div class="showcase_box">
                        <togostanza-dendrogram sparql_api="http://togostanza.org/sparqlist/api/d3sparql_dendrogram?organism=Oryza sativa" title="D3 dendrogram"></togostanza-dendrogram>
                    </div>
                </div>
            </div>
-->
        </div>
    </section>
</template>
<script>
    import axios from 'axios'

    export default {
        data() {
            return {
                parentData : [],
                childData : [],
                parentTotal: 0,
                childTotal: 0,
                toBilsampleLink: '',
                targetTaxId: '',
                targetName: '',
                isStart: false,
                isLoading: false,
                isError: false,
                isDendrogramLoading: false,
                isDendrogramError: false,
            }
        },
        props:{
            tx_taxonomy_id: String,
            scientific_name: String,
            per_page: String,
            sort_key: String,
            order_by: String,
            page_no: String
        },
        mounted: function () {
            this.getData()
        },
        watch: {
            '$route': 'getData'
        },
        methods: {
            getData() {
                if (!Object.keys(this.$route.query).length) {
                    this.isStart = true
                    return
                } else {
                    this.isStart = false
                }
                this.isLoading = true
                this.isError = false

                let targetUrl = this.$route.meta.apiUrl_taxonomy + this.tx_taxonomy_id
                if(!this.scientific_name === false) targetUrl = this.$route.meta.apiUrl_scientific_name + this.scientific_name
                axios
                    .get(targetUrl , {
                        params: {
                            size: this.per_page,
                            sort: this.sort_key,
                            order: this.order_by,
                            page: this.page_no,
                        }
                    })
                    .then(response => {
                        this.parentData = response.data.parent
                        this.parentTotal = response.data.parent.length
                        this.childData = response.data.child
                        this.childTotal = response.data.child.length
                        this.toBilsampleLink = this.$route.meta.linkUrl_biosample + this.tx_taxonomy_id
                        Object.keys(response.data.child).map(([value]) => this.toBilsampleLink += "," + response.data.child[value].taxid)
                        this.isLoading = false
                        this.showDendrogram()
                    })
                    .catch(function (error) {
                        console.log(error);
                        this.parentData = []
                        this.parentTotal = []
                        this.isLoading = false
                        this.isError = true
                    }.bind(this))
            },
            showDendrogram() {
                this.isDendrogramLoading = true
                let targetUrl = this.$route.meta.apiUrl_get_tax_name + this.tx_taxonomy_id
                if(!this.scientific_name === false) targetUrl = this.$route.meta.apiUrl_get_name_tax + this.scientific_name
                axios
                    .get(targetUrl)
                    .then(response => {
                        this.isDendrogramLoading = false
                        if(this.scientific_name !== '') {
                            this.targetTaxId = response.taxonomy_id
                            this.targetName = response.input__name
                        } else {
                            this.targetTaxId = response.input_id
                            this.targetName = response.scientific_name
                        }
                    })
                    .catch(function (error) {
                        console.log(error);
                        this.isDendrogramLoading = false
                        this.isDendrogramError = true
                    }.bind(this))
            },
            onPageChange() {
                this.page_no += 1
                this.getData()
            },
            onSort(field, order) {
                this.sort_key = field
                this.order_by = order
                this.getData()
            }
        }
    }
</script>