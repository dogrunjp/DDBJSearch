<template>
    <form :action="$route.path" method="get">
        <div class="search-section">
            <section id="search" class="content">

                <div v-show="$route.name !== 'taxonomy'">
                    <div class="field is-horizontal">
                        <div class="field-label is-normal"><label class="label">SRA Accessions</label></div>
                        <div class="field-body"><div class="field"><input class="input" type="text" name="assesions"></div></div>
                    </div>
                    <div class="field is-horizontal mb-075">
                        <div class="field-label is-normal"><label class="label">SRA Keyword</label></div>
                        <div class="field-body"><div class="field"><input class="input" type="text" name="keyword"></div></div>
                    </div>
                </div>

                <!-- SRA search -->
                <div v-show="$route.name == 'sra'">
                    <b-collapse :open="false" position="is-bottom" aria-id="contentIdForA11y1" class="search-collapse">
                        <a slot="trigger" slot-scope="props" aria-controls="contentIdForA11y1" class="search-collapse-trigger">
                            <b-icon :icon="!props.open ? 'menu-down' : 'menu-up'"></b-icon>
                            {{ !props.open ? 'All settings' : 'Fewer settings' }}
                        </a>
                        <div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Title</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text"  name="title"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Publication ID</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="publication_id"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">StudyType ID</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="studytype_id"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Library Name</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="library_name"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Library Strategy</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="library_strategy"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Library Source</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="library_source"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Library Selection</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="library_selection"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Platform</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="library_selection"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Instrument model</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="instrument_model"></div></div>
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
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="title" ></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Publication ID</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="publication_id" ></div></div>
                            </div>
                        </div>
                    </b-collapse>
                </div>

                <!-- biosample search -->
                <div v-show="$route.name == 'biosample'">
                    <b-collapse :open="false" position="is-bottom" aria-id="contentIdForA11y1" class="search-collapse">
                        <a slot="trigger" slot-scope="props" aria-controls="contentIdForA11y1" class="search-collapse-trigger">
                            <b-icon :icon="!props.open ? 'menu-down' : 'menu-up'"></b-icon>
                            {{ !props.open ? 'All settings' : 'Fewer settings' }}
                        </a>
                        <div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Taxonomy ID</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="taxonomy_id"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Organism name</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="organism_name"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Title</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="title"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Package</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="package"></div></div>
                            </div>
                        </div>
                    </b-collapse>
                </div>

                <!-- taxonomy search -->
                <div v-show="$route.name == 'taxonomy'">
                    <div class="field is-horizontal">
                        <div class="field-label is-normal">
                            <label class="label">Taxonomy ID</label>
                        </div>
                        <div class="field-body">
                            <div class="field">
                                <b-autocomplete
                                        :data="data"
                                        placeholder="e.g. 4530"
                                        field="title"
                                        :loading="isFetching"
                                        name="taxonomy_id"
                                        @typing="getAsyncData"
                                        @select="option => selected = option">

                                    <template slot-scope="props">
                                        <p>{{ props.option.title }}</p>
                                    </template>
                                </b-autocomplete>
                            </div>
                        </div>
                    </div>
                    <div class="field is-horizontal mb-3">
                        <div class="field-label is-normal">
                            <label class="label">Scientific Name</label>
                        </div>
                        <div class="field-body">
                            <div class="field">
                                <b-autocomplete
                                        :data="data"
                                        placeholder="e.g. Oriza sativa"
                                        field="title"
                                        :loading="isFetching"
                                        name="scientific_name"
                                        @typing="getAsyncData"
                                        @select="option => selected = option">

                                    <template slot-scope="props">
                                        <p>{{ props.option.title }}</p>
                                    </template>
                                </b-autocomplete>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- publication search -->
                <div v-show="$route.name == 'publication'">
                    <b-collapse :open="false" position="is-bottom" aria-id="contentIdForA11y1" class="search-collapse">
                        <a slot="trigger" slot-scope="props" aria-controls="contentIdForA11y1" class="search-collapse-trigger">
                            <b-icon :icon="!props.open ? 'menu-down' : 'menu-up'"></b-icon>
                            {{ !props.open ? 'All settings' : 'Fewer settings' }}
                        </a>
                        <div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">PMID</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="pmid"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Article Title</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="article_title"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">BioProject title</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="bp_title"></div></div>
                            </div>
                            <div class="field is-horizontal">
                                <div class="field-label is-normal"><label class="label">Year</label></div>
                                <div class="field-body"><div class="field"><input class="input"  type="text" name="year"></div></div>
                            </div>
                        </div>
                    </b-collapse>
                </div>



                <div class="field is-horizontal">
                    <p class="search-horizontal-guide">Show </p>
                    <b-select v-model="perPage">
                        <option v-for="pp in perPageList" :value="pp" :key="pp">{{ pp }}</option>
                    </b-select>
                    <p class="search-horizontal-guide">records Sort by </p>
                    <b-select v-model="sortKey">
                        <option v-for="ss in sortList" :value="ss" :key="ss">{{ ss }}</option>
                    </b-select>
                    <button type="submit" class="button is-primary search-horizontal-submit is-fullwidth" expanded>Search</button>
                    <button type="button" class="button is-default" @click="clear">Clear</button>
                </div>


            </section>
        </div>
    </form>
</template>
<script>

    import debounce from 'lodash/debounce'

    export default {
        data() {
            return {
                data: [],
                selected: null,
                isFetching: false,
                sortKey: 'ASSOCIATION',
                sortList: [
                    'ASSOCIATION', 'OTHER1', 'OTHER2'
                ],
                perPage: 10,
                perPageList: [
                    10, 20, 30
                ]
            }
        },
        methods: {
            // You have to install and import debounce to use it,
            // it's not mandatory though.
            getAsyncData: debounce(function (name) {
                if (!name.length) {
                    this.data = []
                    return
                }
                this.isFetching = true
                this.$http.get(`https://api.themoviedb.org/3/search/movie?api_key=bb6f51bef07465653c3e553d6ab161a8&query=${name}`)
                    .then(({ data }) => {
                    this.data = []
                data.results.forEach((item) => this.data.push(item))
            })
                .catch((error) => {
                    this.data = []
                throw error
            })
                .finally(() => {
                    this.isFetching = false
            })
            }, 500),
            clear: function () {
                console.log('clear')
            }
        }
    }
</script>