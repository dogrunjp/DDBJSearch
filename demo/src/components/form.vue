<template>
    <!--<form :action="$route.path" method="get">-->
    <form @submit.prevent="goSearch">
        <div class="search-section">
            <section id="search" class="content">

                <div v-show="$route.name !== 'taxonomy' && $route.name !== 'publication'">
                    <div class="field is-horizontal">
                        <div class="field-label is-normal"><label class="label">SRA Keyword</label></div>
                        <div class="field-body"><div class="field"><input class="input" type="text" v-model="params.keyword"></div></div>
                    </div>
                    <div class="field is-horizontal mb-075">
                        <div class="field-label is-normal"><label class="label">SRA Accessions</label></div>
                        <div class="field-body"><div class="field"><input class="input" type="text" v-model="params.assesions"></div></div>
                    </div>
                </div>

                <!-- SRA search -->
                <div v-show="$route.name == 'sra'">
                    <b-collapse :open="false" position="is-bottom" aria-id="contentIdForA11y1" class="search-collapse">
                        <a slot="trigger" slot-scope="props" aria-controls="contentIdForA11y1" class="search-collapse-trigger">
                            <b-icon :icon="!props.open ? 'menu-down' : 'menu-up'"></b-icon>
                            {{ !props.open ? 'All settings' : 'Fewer settings' }}
                        </a>
                        <div class="columns">
                            <div class="column">
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">Title</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text"  v-model="params.sra_title"></div></div>
                                </div>
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">Publication ID</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.publication_id"></div></div>
                                </div>
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">StudyType ID</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.studytype_id"></div></div>
                                </div>
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">Library Name</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.library_name"></div></div>
                                </div>
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">Library Strategy</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.library_strategy"></div></div>
                                </div>
                            </div>
                            <div class="column">
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">Library Source</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.library_source"></div></div>
                                </div>
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">Library Selection</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.library_selection"></div></div>
                                </div>
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">Platform</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.platform"></div></div>
                                </div>
                                <div class="field is-horizontal">
                                    <div class="field-label is-normal"><label class="label">Instrument model</label></div>
                                    <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.instrument_model"></div></div>
                                </div>
                            </div>
                        </div>
                    </b-collapse>
                </div>


                <!-- bioproject search -->
                <div v-show="$route.name == 'bioproject'">
                    <b-collapse :open="false" position="is-bottom" aria-id="contentIdForA11y1" class="search-collapse">
                        <a slot="trigger" slot-scope="props" aria-controls="contentIdForA11y1" class="search-collapse-trigger">
                            <b-icon :icon="!props.open ? 'menu-down' : 'menu-up'"></b-icon>
                            {{ !props.open ? 'All settings' : 'Fewer settings' }}
                        </a>
                        <div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Title</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.bioproject_title" ></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Publication ID</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.bp_publication_id" ></div></div>
                            </div>
                        </div>
                    </b-collapse>
                </div>

                <!-- biosample search -->
                <div v-show="$route.name == 'biosample'">
                    <div class="field is-horizontal">
                        <div class="field-label is-normal"><label class="label">Taxonomy ID</label></div>
                        <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.bs_taxonomy_id"></div></div>
                    </div>
                    <div class="field is-horizontal mb-075">
                        <div class="field-label is-normal"><label class="label">Organism name</label></div>
                        <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.bs_organism_name"></div></div>
                    </div>
                    <b-collapse :open="false" position="is-bottom" aria-id="contentIdForA11y1" class="search-collapse">
                        <a slot="trigger" slot-scope="props" aria-controls="contentIdForA11y1" class="search-collapse-trigger">
                            <b-icon :icon="!props.open ? 'menu-down' : 'menu-up'"></b-icon>
                            {{ !props.open ? 'All settings' : 'Fewer settings' }}
                        </a>
                        <div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Title</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.bs_title"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Package</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.package"></div></div>
                            </div>
                        </div>
                    </b-collapse>
                </div>

                <!-- taxonomy search -->
                <div v-show="$route.name == 'taxonomy'">
                    <div class="columns mb-075">
                        <div class="column">
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label -width-not-set">Taxonomy ID</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.tx_taxonomy_id"></div></div>
                            </div>
                        </div>
                        <div class="column is-narrow">
                            <div class="field-label is-normal"><label class="label">OR</label></div>
                        </div>
                        <div class="column">
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label -width-not-set">Scientific Name</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.scientific_name"></div></div>
                            </div>
                        </div>
                    </div>
                    <p class="mb-3">If you enter a Scientific Name, that takes precedence.</p>
                </div>

                <!-- publication search -->
                <div v-show="$route.name == 'publication'">
                    <div class="columns mb-075">
                        <div class="column">
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Article Title</label></div>
                                <div class="field-body"><div class="field">
                                    <b-autocomplete
                                            :data="data"
                                            v-model="params.article_title"
                                            placeholder="e.g. LRIG1"
                                            field="ArticleTitle"
                                            :loading="isFetching"
                                            @typing="keywordSearch"
                                            @select="option => selected = option">

                                        <template slot-scope="props">
                                            <p>{{ props.option.ArticleTitle }}</p>
                                        </template>
                                    </b-autocomplete>
                                </div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">BioProject title</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.pub_bp_title"></div></div>
                            </div>
                        </div>
                        <div class="column">
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Journal</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" v-model="params.journal"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Year</label></div>
                                <div class="field-body"><div class="field"><input class="input" type="text" v-model="params.pub_year"></div></div>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="field is-horizontal">
                    <p class="search-horizontal-guide">Show </p>
                    <b-select v-model="params.per_page">
                        <option v-for="pp in perPageList" :value="pp" :key="pp">{{ pp }}</option>
                    </b-select>
                    <p class="search-horizontal-guide">records Sort by </p>
                    <b-select v-model="params.sort_key">
                        <option v-for="ss in sortList" :value="ss" :key="ss">{{ ss }}</option>
                    </b-select>
                    <button type="submit" class="button is-primary search-horizontal-submit is-fullwidth" expanded><i class="fas fa-search"></i>Search</button>
                    <button type="button" class="button is-default" @click="clear"><i class="fas fa-ban"></i>Clear</button>
                </div>


            </section>
        </div>
    </form>
</template>
<script>

    import debounce from 'lodash/debounce'
    import axios from 'axios'

    export default {
        data() {
            return {
                data: [],
                selected: null,
                isFetching: false,
                sortList: ['Accessions', 'OTHER1', 'OTHER2'],
                perPageList: [10, 20, 30],
                params: {
                    article_title: '',
                    assesions: '',
                    bioproject_title: '',
                    bp_publication_id: '',
                    bp_title: '',
                    bs_organism_name: '',
                    bs_taxonomy_id: '',
                    bs_title: '',
                    instrument_model: '',
                    keyword: '',
                    library_name: '',
                    library_selection: '',
                    library_source: '',
                    library_strategy: '',
                    package: '',
                    platform: '',
                    journal: '',
                    pub_year: '',
                    publication_id: '',
                    scientific_name: '',
                    sra_title: '',
                    studytype_id: '',
                    tx_taxonomy_id: '',

                    per_page: '10',
                    sort_key: 'Accessions'
                }
            }
        },
        mounted: function () {
            this.setDefaultValues()
        },
        watch: {
            '$route': 'setDefaultValues'
        },
        methods: {
            goSearch: function () {
                if (this.$route.name == 'taxonomy') {
                    this.$router.push({
                        query: {
                            tx_taxonomy_id: this.params.tx_taxonomy_id,
                            scientific_name: this.params.scientific_name,
                            per_page: this.params.per_page,
                            sort_key: this.params.sort_key,
                            order_by: 'asc',
                            page_no: 1
                        }
                    })
                }
                if (this.$route.name == 'publication') {
                    this.$router.push({
                        query: {
                            assesions: this.params.assesions,
                            keyword: this.params.keyword,
                            journal: this.params.journal,
                            article_title: this.params.article_title,
                            bp_title: this.params.bp_title,
                            pub_year: this.params.pub_year,
                            per_page: this.params.per_page,
                            sort_key: this.params.sort_key,
                            order_by: 'asc',
                            page_no: 1
                        }
                    })
                }
            },
            clear: function () {
                Object.entries(this.params).forEach(([key]) => this.params = {[key]:''})
                this.sortList = this.$route.meta.sortList
                this.params.sort_key = this.sortList[0]
                this.params.per_page = this.perPageList[0]
                this.$router.push({ name: this.$route.name })
            },
            setDefaultValues: function () {
                this.params = Object.assign(this.params, this.$route.query);
                this.sortList = this.$route.meta.sortList
                this.params.sort_key = this.sortList[0]
            },
            //TODO サンプルとして残します
            keywordSearch: debounce(function (name) {
                if (!name.length) {
                    this.data = []
                    return
                }
                this.isFetching = true
                axios.get(`http://dbcls-sra-api.bmu.jp/api/publication/search?article_title=${name}`)
                    .then(({ data }) => {
                    this.data = []
                    data.data.forEach((item) => this.data.push(item))
                })
                .catch((error) => {
                    this.data = []
                    throw error
                })
                .finally(() => {
                    this.isFetching = false
                })
            }, 500)
        }
    }
</script>