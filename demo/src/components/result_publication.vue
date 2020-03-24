<template>
    <section id="result" class="content">
        <p class="title is-5 has-text-centered">Search Results for term: aaa - <span class="is-primary">{{ total }}</span> Publication entries</p>
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
                <b-table-column
                        field="PMID"
                        label="PMID"
                        sortable
                >
                    <template>
                        <a @click="taxidSelected(props.row.PMID)">
                            {{ props.row.PMID }}
                        </a>
                    </template>
                </b-table-column>

                <b-table-column
                        field="ArticleTitle"
                        label="ArticleTitle">
                    {{ props.row.ArticleTitle }}
                </b-table-column>
                <b-table-column
                        field="Journal"
                        label="Journal">
                    {{ props.row.Journal }}
                </b-table-column>
                <b-table-column
                        field="Year"
                        label="Year">
                    {{ props.row.Year }}
                </b-table-column>
                <b-table-column
                        field="BioProject"
                        label="BioProject">
                    <template>
                        <a @click="taxidSelected(props.row.BioProject)">
                            {{ props.row.BioProject }}
                        </a>
                    </template>
                </b-table-column>
                <b-table-column
                        field="Title"
                        label="Title">
                    {{ props.row.Title }}
                </b-table-column>
            </template>
        </b-table>
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
                targetUrl: 'http://dbcls-sra-api.bmu.jp/api/publication/search?article_title=Bacillus&year=2009&bp_title=Genome'
            }
        },
        mounted: function () {
            this.getData()
        },
        methods: {
            getData() {
                axios
                    .get(this.targetUrl)
                    .then(response => {
                    this.pubData = response.data.data
                    this.total = response.data.numfound
                console.log(this.pubData)
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