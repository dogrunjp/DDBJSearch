<template>
    <section id="result" class="content">
        <div v-show="isStart" class="box is-primary has-text-centered result-box -start"><i class="fas fa-dna"></i>Let's search Taxonomy entries!</div>
        <div v-show="isLoading" class="box is-info has-text-centered result-box -search"><i class="fas fa-spinner fa-spin"></i>Now searching...</div>
        <div v-show="isError" class="box is-warning is-light has-text-centered result-box -error"><i class="fas fa-exclamation-triangle"></i>Error / Please Try different search conditions...</div>
        <div v-show="!isStart & !isLoading & !isError" class="search_loaded">
            <div class="box is-primary result-box -result">
                <p>terms : <span>{{ targetTxId }} {{ targetTxName }}</span> <a class="button is-info toDetail" :href="toBilsampleLink"><i class="fas fa-external-link-alt"></i>Show all Taxonomies</a></p>
                <p>Parents : Total <span>{{ parentData.length }}</span> records</p>
                <p>Children : Total <span>{{ childData.length }}</span> records / <span>{{ per_page }}</span> records / Sort by <span>{{ sort_key }}</span> / Order <span> {{ order_by }}</span></p>
            </div>

            <p class="title is-5">Parents</p>
            <b-table
                    :data="parentData"
                    ref="table"
                    hoverable
                    class="mb-3">

                <template slot-scope="props">
                    <b-table-column field="TaxonomyID" label="Taxonomy ID">
                        <template>
                            <router-link :to="{
                                name: 'taxonomy',
                                query:{
                                    tx_taxonomy_id: props.row.taxid,
                                    scientific_name: '',
                                    sort_key: sort_key,
                                    order_by: order_by,
                                    per_page: per_page,
                                 }
                             }">{{ props.row.taxid }}</router-link>
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

                    :default-sort="[targetSortKey, order_by]"

                    paginated
                    :total="childData.length"
                    :per-page="per_page">

                <template slot-scope="props">
                    <b-table-column field="taxid" label="Taxonomy ID" width="180" sortable>
                        <template>
                            <router-link :to="{
                                name: 'taxonomy',
                                query:{
                                    tx_taxonomy_id: props.row.taxid,
                                    scientific_name: '',
                                    sort_key: sort_key,
                                    order_by: order_by,
                                    per_page: per_page,
                                 }
                             }">{{ props.row.taxid }}</router-link>
                        </template>
                    </b-table-column>
                    <b-table-column field="label" label="Scientific Name" sortable>{{ props.row.label }}</b-table-column>
                </template>
            </b-table>

            <dendrogram :targetTxName="targetTxName"></dendrogram>
        </div>
    </section>
</template>
<script>
    import axios from 'axios'
    import dendrogram from './result_taxonomy_dendrogram.vue'

    export default {
        data() {
            return {
                parentData : [],
                childData : [],
                toBilsampleLink: '',
                targetTxId: '',
                targetTxName: '',
                targetSortKey : 'taxid',
                isStart: false,
                isLoading: false,
                isError: false,
            }
        },
        props:{
            tx_taxonomy_id: String,
            scientific_name: String,
            per_page: Number,
            sort_key: String,
            order_by: String
        },
        components: {
            dendrogram
        },
        mounted: function () {
            this.search()
        },
        watch: {
            '$route': 'search'
        },
        methods: {
            search() {
                if (!Object.keys(this.$route.query).length) {
                    this.isStart = true
                    this.isError = false
                    return
                } else {
                    this.isStart = false
                }
                this.isLoading = true
                this.isError = false

                this.setTargetSortKey()

                if(!this.scientific_name === false) {
                    axios
                        .get(this.$route.meta.apiUrl_get_name_tax + this.scientific_name)
                        .then(res => {
                            this.targetTxId = res.data.taxonomy_id.split("/")[4]
                            this.targetTxName = this.scientific_name
                            this.getData(this.$route.meta.apiUrl_taxonomy + this.targetTxId)
                        })
                        .catch(function (error) {
                            console.log(error)
                            this.isError = true
                        }.bind(this))
                        .finally(function () {
                            this.isLoading = false
                        }.bind(this))
                } else {
                    axios
                        .get(this.$route.meta.apiUrl_get_tax_name + this.tx_taxonomy_id)
                        .then(res => {
                            this.targetTxId = this.tx_taxonomy_id
                            this.targetTxName = res.data.scientific_name
                            this.getData(this.$route.meta.apiUrl_taxonomy + this.targetTxId)
                        })
                        .catch(function (error) {
                            console.log(error)
                            this.isError = true
                        }.bind(this))
                        .finally(function () {
                            this.isLoading = false
                        }.bind(this))
                }
            },
            getData(targetUrl) {
                axios
                    .get(targetUrl)
                    .then(response => {
                        this.parentData = response.data.parent
                        this.childData = response.data.child
                        this.toBilsampleLink = this.$route.meta.linkUrl_biosample + this.tx_taxonomy_id
                        Object.keys(response.data.child).map(([value]) => this.toBilsampleLink += "," + response.data.child[value].taxid)
                    })
                    .catch(function (error) {
                        console.log(error)
                        this.isError = true
                    }.bind(this))
            },
            setTargetSortKey() {
                if(this.sort_key == 'TaxonomyID') {
                    this.targetSortKey = 'taxid'
                } else if (this.sort_key == 'ScientificName') {
                    this.targetSortKey = 'field'
                } else {
                    this.targetSortKey = this.sort_key
                }
            }
        }
    }
</script>