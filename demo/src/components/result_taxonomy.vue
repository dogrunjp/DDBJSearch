<template>
    <section id="result" class="content">
        <div v-show="isStart" class="box is-primary has-text-centered result-box -start"><i class="fas fa-dna"></i>Let's search Taxonomy entries!</div>
        <div v-show="isLoading" class="box is-info has-text-centered result-box -search"><i class="fas fa-spinner"></i>Now searching...</div>
        <div v-show="isError" class="box is-warning has-text-centered result-box -error"><i class="fas fa-sad-tear"></i>Sorry caused an error...</div>
        <div v-show="!isStart & !isLoading & !isError" class="search_loaded">
            <div class="box is-primary result-box -result">
                <p>terms:<span>{{ tx_taxonomy_id }} {{ scientific_name }}</span></p>
            </div>

            <p class="title is-5">Parents</p>
            <b-table
                    :data="parentData"
                    ref="table"
                    hoverable
                    class="mb-3">

                <template slot-scope="props">
                    <b-table-column field="taxid" label="Taxonomy ID" sortable>
                        <template>
                            <router-link :to="{ name: 'taxonomy', query:{ tx_taxonomy_id: props.row.taxid } }">{{ props.row.taxid }}</router-link>
                        </template>
                    </b-table-column>
                    <b-table-column field="label" label="Scientific Name">{{ props.row.label }}</b-table-column>
                </template>
            </b-table>

            <p class="title is-5">Children</p>
            <b-table
                    :data="childData"
                    ref="table"
                    hoverable
                    class="mb-3">

                <template slot-scope="props">
                    <b-table-column field="taxid" label="Taxonomy ID" sortable>
                        <template>
                            <router-link :to="{ name: 'taxonomy', query:{ tx_taxonomy_id: props.row.taxid } }">{{ props.row.taxid }}</router-link>
                        </template>
                    </b-table-column>
                    <b-table-column field="label" label="Scientific Name">{{ props.row.label }}</b-table-column>
                </template>
            </b-table>
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
                total: 0,
                isStart: false,
                isLoading: false,
                isError: false,
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
                axios
                    .get(targetUrl)
                    .then(response => {
                        console.log(response);
                        this.parentData = response.data.parent
                        this.childData = response.data.child
                        this.total = 100; //response.data.numfound // TODO
                        this.isLoading = false
                    })
                    .catch(function (error) {
                        console.log(error);
                        this.pubData = []
                        this.isLoading = false
                        this.isError = true
                    }).bind(this)
            },
        }
    }
</script>