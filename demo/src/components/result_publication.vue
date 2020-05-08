<template>
    <section id="result" class="content">
        <div v-show="isStart" class="box is-primary has-text-centered result-box -start"><i class="fas fa-book"></i>Let's search Publication entries!</div>
        <div v-show="isError" class="box is-warning has-text-centered result-box -error"><i class="fas fa-exclamation-triangle"></i>Error / Please Try different search conditions...</div>
        <div v-show="!isStart & !isError" class="search_loaded">
            <div class="box is-primary result-box -result">
                <p>Results : <span>{{ total }}</span> Publication entries</p>
                <p>terms : <span>{{ article_title }} {{ journal }} {{ bp_title }} {{ pub_year }}</span></p>
                <p>Show <span>{{ per_page }}</span> records / Sort by <span>{{ targetSortKey }} {{ targetOrderBy }}</span> / Page no. <span>{{ page_no }}</span></p>
            </div>
        </div>
        <div v-show="!isStart & !isError">
            <b-table
                    :data="pubData"
                    ref="table"
                    hoverable

                    :loading="isLoading"

                    backend-sorting
                    :default-sort="targetSortKey"
                    :default-sort-direction="targetOrderBy"
                    @sort="onSort"

                    paginated
                    backend-pagination
                    @page-change="onPageChange"
                    :total="total"
                    :per-page="per_page">

                <template slot-scope="props">
                    <b-table-column field="BioProject" label="BioProject" sortable>
                        <template>
                            <a :href="'http://sra.bhx.jp/details.html?db=bioproject&accession=' + props.row.BioProject">{{ props.row.BioProject }}</a>
                        </template>
                    </b-table-column>
                    <b-table-column field="Title" label="Title">{{ props.row.Title }}</b-table-column>
                    <b-table-column field="PMID" label="PMID" sortable>{{ props.row.PMID }}</b-table-column>
                    <b-table-column field="Journal" label="Journal" sortable>
                        <template>
                            <router-link :to="{ name: 'publication', query:{
                                journal: props.row.Journal,
                                article_title: article_title,
                                bp_title: bp_title,
                                pub_year: pub_year,
                                per_page: per_page,
                                sort_key: targetSortKey,
                                order_by: targetOrderBy
                             } }">{{ props.row.Journal }}</router-link>
                        </template>
                    </b-table-column>
                    <b-table-column field="ArticleTitle" label="ArticleTitle">{{ props.row.ArticleTitle }}</b-table-column>
                    <b-table-column field="Year" label="Year" sortable>{{ props.row.Year }}</b-table-column>
                </template>
            </b-table>
        </div>
    </section>
</template>
<script>
    import axios from 'axios'

    export default {
        data() {
            return {
                pubData : [],
                total: 0,
                isStart: false,
                isLoading: false,
                isError: false,
                page_no: 1,
                targetSortKey: '',
                targetOrderBy: 'asc'
            }
        },
        props:{
            journal: String,
            article_title: String,
            bp_title: String,
            pub_year: String,
            per_page: Number,
            sort_key: String,
            order_by: String
        },
        mounted: function () {
            this.onLoad()
        },
        watch: {
            '$route': 'onLoad'
        },
        methods: {
            onLoad() {
                if(!Object.keys(this.$route.query).length) {
                    this.isStart = true
                    return
                } else {
                    this.targetSortKey = this.sort_key
                    this.targetOrderBy = this.order_by
                    this.getData()
                }
            },
            getData() {
                this.isStart = false
                this.isLoading = true
                this.isError = false

                axios
                    .get(this.$route.meta.apiUrl , {
                        params: {
                            article_title: (this.article_title == null) ? '' : this.article_title,
                            journal: (this.journal == null) ? '' : this.journal,
                            bp_title: (this.bp_title == null) ? '' : this.bp_title,
                            year: (this.pub_year == null) ? '' : this.pub_year,
                            size: this.per_page,
                            sort: (this.targetSortKey == null) ? '' : this.targetSortKey.toLowerCase(),
                            order: this.targetOrderBy,
                            page: this.page_no
                        }
                    })
                    .then(response => {
                        this.pubData = response.data.data
                        this.total = response.data.numfound
                    })
                    .catch(error => {
                        console.log(error)
                        this.pubData = []
                        this.isError = true
                    })
                    .finally(() => {
                        this.isLoading = false
                    })
            },
            onPageChange() {
                this.page_no += 1
                this.getData()
            },
            onSort(field, order) {
                this.targetSortKey = field
                this.targetOrderBy = order
                this.getData()
            }
        }
    }
</script>