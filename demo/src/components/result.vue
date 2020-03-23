<template>
    <section id="result" class="content">
        <p class="title is-5">Search Results for term: aaa - <span class="is-primary">{{ total }}</span> Taxonomies entries</p>
        <b-table
                :data="data"
                ref="table"
                hoverable

                backend-sorting
                :default-sort="defaultSort"
                @sort="onSort"

                detailed
                custom-detail-row
                detail-key="taxid"
                :show-detail-icon="showDetailIcon"
                @details-open="(row, index) => onDetailOpen(row, index)"

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
                        field="taxid"
                        label="Taxonomy ID"
                        width="300"
                        sortable
                >
                    <template>
                        <a @click="taxidSelected(props.row.taxid)">
                            {{ props.row.taxid }}
                        </a>
                    </template>
                </b-table-column>

                <b-table-column
                        field="lavel"
                        label="Lavel"
                        sortable
                >
                    {{ props.row.lavel }}
                </b-table-column>
            </template>

            <template slot="detail" slot-scope="props">
                <tr v-for="parent in props.row.items.parents" :key="parent.taxid">
                    <td></td>
                    <td>
                        <span class="tag for-table-tag is-parent">parent</span>
                        <a @click="taxidSelected(parent.taxid)">{{ parent.taxid }}</a>
                    </td>
                    <td>{{ parent.label }}</td>
                </tr>
                <tr v-for="sibling in props.row.items.siblings" :key="sibling.taxid">
                    <td></td>
                    <td>
                        <span class="tag for-table-tag is-sibling">sibling</span>
                        <a @click="taxidSelected(sibling.taxid)">{{ sibling.taxid }}</a>
                    </td>
                    <td>{{ sibling.label }}</td>
                </tr>
            </template>
        </b-table>

    </section>
</template>
<script>

    var taxData = [
        {
            taxid: 9606,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960601,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960602,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960603,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960604,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960605,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960606,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960607,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960608,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960609,
            lavel: 'Homo sapiens (human)',
        },
        {
            taxid: 960610,
            lavel: 'Homo sapiens (human)',
        },
    ]

    var relatedData = {
        "parents": [
            {
                "taxid": "9605",
                "label": "Homo"
            }
        ],
        "siblings": [
            {
                "taxid": "741158",
                "label": "Homo sapiens subsp. 'Denisova'"
            },
            {
                "taxid": "63221",
                "label": "Homo sapiens neanderthalensis"
            },
            {
                "taxid": "1425170",
                "label": "Homo heidelbergensis"
            },
            {
                "taxid": "9606",
                "label": "Homo sapiens"
            }
        ]
    }

    export default {
        data() {
            return {
                data : taxData,
                relatedData: relatedData,
                showDetailIcon: true,
                defaultSort: "['taxid', 'asc']",
                sortIcon: 'arrow-up',
                sortIconSize: 'is-small',
                currentPage: 1,
                perPage: 10,
                loading: false,
                total: taxData.length
            }
        },
        methods: {
            taxidSelected(taxid){
                this.$buefy.toast.open({
                    message: 'You clicked taxonomy ID：' + taxid,
                    type: 'is-dark'
                })
            },
            onDetailOpen(row) {
                row['items'] = this.relatedData
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