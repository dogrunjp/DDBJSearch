<template>
    <section id="result" class="content">
        <div v-show="isStart" class="box is-primary has-text-centered result-box -start"><i class="fas fa-rocket"></i>  Let's Search Publication entries!</div>
        <div v-show="isLoading" class="box is-info has-text-centered result-box -search"><i class="fas fa-search"></i>  Now searching...</div>
        <div v-show="isError" class="box is-warning has-text-centered result-box -error"><i class="fas fa-sad-tear"></i>  Sorry caused an error...</div>
        <div v-show="!isStart" class="search_loaded">
            <p class="title is-5 has-text-centered">Search Results for term: {{ query }} - <span class="is-primary">{{ total }}</span> Publication entries</p>
            <b-table
                    :data="pubData"
                    ref="table"
                    hoverable

                    backend-sorting
                    :default-sort="defaultSort"
                    @sort="onSort"

                    paginated
                    backend-pagination
                    @page-change="onPageChange"
                    :total="total"
                    :per-page="perPage"
                    aria-next-label="Next page"
                    aria-previous-label="Previous page"
                    aria-page-label="Page"
                    aria-current-label="Current page">

                <template slot-scope="props">
                    <b-table-column field="BioProject" label="BioProject" sortable>
                        <template>
                            <a @click="taxidSelected(props.row.BioProject)">
                                {{ props.row.BioProject }}
                            </a>
                        </template>
                    </b-table-column>
                    <b-table-column field="Title" label="Title">
                        {{ props.row.Title }}
                    </b-table-column>
                    <b-table-column field="PMID" label="PMID" sortable>
                        <template>
                            <a @click="taxidSelected(props.row.PMID)">
                                {{ props.row.PMID }}
                            </a>
                        </template>
                    </b-table-column>
                    <b-table-column field="Journal" label="Journal">
                        {{ props.row.Journal }}
                    </b-table-column>
                    <b-table-column field="ArticleTitle" label="ArticleTitle">
                        {{ props.row.ArticleTitle }}
                    </b-table-column>
                    <b-table-column field="Year" label="Year">
                        {{ props.row.Year }}
                    </b-table-column>
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
                showDetailIcon: false,
                defaultSort: "['taxid', 'asc']",
                sortIcon: 'arrow-up',
                sortIconSize: 'is-small',
                currentPage: 1,
                perPage: 10,
                loading: false,
                total: 0,
                targetUrl: 'http://dbcls-sra-api.bmu.jp/api/publication/search',
                isStart: false,
                isLoading: false,
                isError: false,
                query : ""
            }
        },
        mounted: function () {
            this.getData()
        },
        watch: {
            '$route': 'getData'
        },
        methods: {
            getData() {
                if(!Object.keys(this.$route.query).length) {
                    this.isStart = true
                    return
                } else {
                    this.isStart = false
                }
                this.isLoading = true
                this.isError = false
                //this.query = //TODO
                axios
                    .get(this.targetUrl, {
                        params: {
                            pmid: this.$route.query.pmid,
                            article_title: this.$route.query.article_title,
                            bp_title: this.$route.query.bp_title,
                            year: this.$route.query.year,
                            assesions: this.$route.query.assesions,
                            keyword: this.$route.query.keyword,
                        }
                    })
                    .then(response => {
                        this.pubData = response.data.data
                        this.total = response.data.numfound
                        console.log(this.pubData)
                        this.isLoading = false
                    })
                    .catch(function (error) {
                        console.log(error);
                        this.pubData = []
                        this.isLoading = false
                        this.isError = true
                    })
            },
            taxidSelected(taxid){
                this.$buefy.toast.open({
                    message: 'You clicked taxonomy ID：' + taxid,
                    type: 'is-dark'
                })
            },
            onPageChange() {
                this.$buefy.toast.open('page change!')
            },
            onSort() {
                this.$buefy.toast.open('sort change!')
            }
        }
    }
</script>