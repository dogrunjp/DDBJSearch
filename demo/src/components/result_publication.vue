<template>
    <section id="result" class="content">
        <div v-show="isStart" class="box is-primary has-text-centered result-box -start"><i class="fas fa-book"></i>Let's search Publication entries!</div>
        <div v-show="isLoading" class="box is-info has-text-centered result-box -search"><i class="fas fa-spinner fa-spin"></i>Now searching...</div>
        <div v-show="isError" class="box is-warning has-text-centered result-box -error"><i class="fas fa-sad-tear"></i>Sorry caused an error...</div>
        <div v-show="!isStart & !isLoading & !isError" class="search_loaded">
            <div class="box is-primary result-box -result">
                <p>Results : <span>{{ total }}</span> Publication entries</p>
                <p>terms : <span>{{ assesions }} {{ keyword }} {{ journal }} {{ article_title }} {{ bp_title }} {{ pub_year }}</span></p>
                <p>Show <span>{{ per_page }}</span> records / Sort by <span>{{ sort_key }}</span> / Order <span> {{ order_by }}</span> / Page no. <span>{{ page_no }}</span></p>
            </div>
        </div>
        <div v-show="!isStart & !isError" class="search_loaded">
            <b-table
                    :data="pubData"
                    ref="table"
                    hoverable

                    backend-sorting
                    :default-sort="[sort_key, order_by]"
                    @sort="onSort"

                    paginated
                    backend-pagination
                    @page-change="onPageChange"
                    :total="total"
                    :per-page="per_page">

                <template slot-scope="props">
                    <b-table-column field="BioProject" label="BioProject" sortable>
                        <template>
                            <router-link :to="{ name: 'bioproject', query:{ bp_publication_id: props.row.BioProject } }">{{ props.row.BioProject }}</router-link>
                        </template>
                    </b-table-column>
                    <b-table-column field="Title" label="Title">{{ props.row.Title }}</b-table-column>
                    <b-table-column field="PMID" label="PMID" sortable>
                        <template>
                            <router-link :to="{ name: 'publication', query:{ pmid: props.row.PMID } }">{{ props.row.PMID }}</router-link>
                        </template>
                    </b-table-column>
                    <b-table-column field="Journal" label="Journal">{{ props.row.Journal }}</b-table-column>
                    <b-table-column field="ArticleTitle" label="ArticleTitle">{{ props.row.ArticleTitle }}</b-table-column>
                    <b-table-column field="Year" label="Year">{{ props.row.Year }}</b-table-column>
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
            }
        },
        props:{
            journal: String,
            article_title: String,
            bp_title: String,
            pub_year: String,
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
                if(!Object.keys(this.$route.query).length) {
                    this.isStart = true
                    return
                } else {
                    this.isStart = false
                }
                this.isLoading = true
                this.isError = false
                axios
                    .get(this.$route.meta.apiUrl , {
                        params: {
                            journal: this.pmid,
                            article_title: this.article_title,
                            bp_title: this.bp_title,
                            year: this.pub_year,
                            size: this.per_page,
                            sort: this.sort_key,
                            order: this.order_by,
                            page: this.page_no,
                        }
                    })
                    .then(response => {
                        this.pubData = response.data.data
                        if (response.data.numfound >= this.per_page) {
                            this.total = 100 //TODO
                        } else {
                            this.total = response.data.numfound
                        }
                        this.isLoading = false
                    })
                    .catch(function (error) {
                        console.log(error);
                        this.pubData = []
                        this.isLoading = false
                        this.isError = true
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