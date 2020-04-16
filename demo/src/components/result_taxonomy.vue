<template>
    <section id="result" class="content">
        <div v-show="isStart" class="box is-primary has-text-centered result-box -start"><i class="fas fa-dna"></i>Let's search Taxonomy entries!</div>
        <div v-show="isError" class="box is-warning is-light has-text-centered result-box -error"><i class="fas fa-exclamation-triangle"></i>Error / Please Try different search conditions...</div>
        <div v-show="!isStart & !isError" class="search_loaded">
            <div class="box is-primary result-box -result">
                <p>terms : <span>{{ targetTxId }} {{ targetTxName }}</span> <a class="button is-info toDetail" :href="toBilsampleLink"><i class="fas fa-external-link-alt"></i>Show all Taxonomies</a></p>
                <p>Parents : Total <span>{{ dataParent.length }}</span> records</p>
                <p>Children : Total <span>{{ dataChild.length }}</span> records / <span>{{ per_page }}</span> records / Sort by <span>{{ sort_key }} {{ targetOrderby }}</span></p>
            </div>

            <p class="title is-5">Parents</p>
            <b-table
                    :data="dataParent"
                    :loading="isLoading"
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
                                    sort_key: targetSortKey,
                                    order_by: targetOrderby,
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
                    :data="dataChild"
                    :loading="isLoading"
                    ref="table"
                    hoverable
                    class="mb-3"

                    :default-sort="[targetSortKey, targetOrderby]"

                    paginated
                    :total="dataChild.length"
                    :per-page="per_page">

                <template slot-scope="props">
                    <b-table-column field="taxid" label="Taxonomy ID" width="180" sortable>
                        <template>
                            <router-link :to="{
                                name: 'taxonomy',
                                query:{
                                    tx_taxonomy_id: props.row.taxid,
                                    scientific_name: '',
                                    sort_key: targetSortKey,
                                    order_by: targetOrderby,
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
                dataParent : [],
                dataChild : [],
                toBilsampleLink: '',
                targetTxId: '',
                targetTxName: '',
                targetSortKey : 'taxid',
                targetOrderby : 'asc',
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
            this.onLoad()
        },
        watch: {
            '$route': 'onLoad'
        },
        methods: {
            onLoad() {
                if (!Object.keys(this.$route.query).length) {
                    this.isStart = true
                    this.isError = false
                    return
                } else {
                    if(this.sort_key == 'TaxonomyID') {
                        this.targetSortKey = 'taxid'
                    } else if (this.sort_key == 'ScientificName') {
                        this.targetSortKey = 'field'
                    }
                    this.targetOrderBy = this.order_by

                    this.setTargetSettings()
                }
            },
            setTargetSettings() {
                this.isStart = false
                this.isLoading = true
                this.isError = false

                if(!this.scientific_name === false) {
                    axios
                        .get(this.$route.meta.apiUrl_get_name_tax + this.scientific_name)
                        .then(res => {
                            this.targetTxId = res.data.taxonomy_id.split("/")[4]
                            this.targetTxName = this.scientific_name
                            this.getData(this.$route.meta.apiUrl_taxonomy + this.targetTxId)
                        })
                        .catch(error => {
                            console.log(error)
                            this.isError = true
                        })
                        .finally(() => {
                            this.isLoading = false
                        })
                } else {
                    axios
                        .get(this.$route.meta.apiUrl_get_tax_name + this.tx_taxonomy_id)
                        .then(res => {
                            this.targetTxId = this.tx_taxonomy_id
                            this.targetTxName = res.data.scientific_name
                            this.getData(this.$route.meta.apiUrl_taxonomy + this.targetTxId)
                        })
                        .catch(error => {
                            console.log(error)
                            this.isError = true
                        })
                        .finally(() => {
                            this.isLoading = false
                        })
                }
            },
            getData(targetUrl) {
                axios
                    .get(targetUrl)
                    .then(response => {
                        this.dataParent = response.data.parent
                        this.dataChild = response.data.child
                        this.toBilsampleLink = this.$route.meta.linkUrl_biosample + this.tx_taxonomy_id
                        Object.keys(response.data.child).map(([value]) => this.toBilsampleLink += "," + response.data.child[value].taxid)
                    })
                    .catch(error => {
                        console.log(error)
                        this.isError = true
                    })
            }
        }
    }
</script>