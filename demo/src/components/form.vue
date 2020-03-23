<template>
    <div class="search-section">
        <section id="search" class="content">
            <div class="field is-horizontal">
                <div class="field-label is-normal">
                    <label class="label">Taxonomy ID</label>
                </div>
                <div class="field-body">
                    <div class="field">
                        <b-autocomplete
                                :data="data"
                                placeholder="e.g. Fight Club"
                                field="title"
                                :loading="isFetching"
                                @typing="getAsyncData"
                                @select="option => selected = option">

                            <template slot-scope="props">
                                <div class="media">
                                    <div class="media-left">
                                        <img width="32" :src="`https://image.tmdb.org/t/p/w500/${props.option.poster_path}`">
                                    </div>
                                    <div class="media-content">
                                        {{ props.option.title }}
                                        <br>
                                        <small>
                                            Released at {{ props.option.release_date }},
                                            rated <b>{{ props.option.vote_average }}</b>
                                        </small>
                                    </div>
                                </div>
                            </template>
                        </b-autocomplete>
                    </div>
                </div>
            </div>
            <div class="field is-horizontal">
                <div class="field-label is-normal">
                    <label class="label">Keyword</label>
                </div>
                <div class="field-body">
                    <div class="field">
                        <b-autocomplete
                                :data="data"
                                placeholder="e.g. Fight Club"
                                field="title"
                                :loading="isFetching"
                                @typing="getAsyncData"
                                @select="option => selected = option">

                            <template slot-scope="props">
                                <div class="media">
                                    <div class="media-left">
                                        <img width="32" :src="`https://image.tmdb.org/t/p/w500/${props.option.poster_path}`">
                                    </div>
                                    <div class="media-content">
                                        {{ props.option.title }}
                                        <br>
                                        <small>
                                            Released at {{ props.option.release_date }},
                                            rated <b>{{ props.option.vote_average }}</b>
                                        </small>
                                    </div>
                                </div>
                            </template>
                        </b-autocomplete>
                    </div>
                </div>
            </div>
            <b-collapse :open="false" position="is-bottom" aria-id="contentIdForA11y1" class="search-collapse">
                <a slot="trigger" slot-scope="props" aria-controls="contentIdForA11y1" class="search-collapse-trigger">
                    <b-icon :icon="!props.open ? 'menu-down' : 'menu-up'"></b-icon>
                    {{ !props.open ? 'All settings' : 'Fewer settings' }}
                </a>
                <div>
                    <div class="field is-horizontal">
                        <div class="field-label is-normal">
                            <label class="label">More Settings</label>
                        </div>
                        <div class="field-body">
                            <div class="field">
                                <b-autocomplete
                                        :data="data"
                                        placeholder="e.g. Fight Club"
                                        field="title"
                                        :loading="isFetching"
                                        @typing="getAsyncData"
                                        @select="option => selected = option">

                                    <template slot-scope="props">
                                        <div class="media">
                                            <div class="media-left">
                                                <img width="32" :src="`https://image.tmdb.org/t/p/w500/${props.option.poster_path}`">
                                            </div>
                                            <div class="media-content">
                                                {{ props.option.title }}
                                                <br>
                                                <small>
                                                    Released at {{ props.option.release_date }},
                                                    rated <b>{{ props.option.vote_average }}</b>
                                                </small>
                                            </div>
                                        </div>
                                    </template>
                                </b-autocomplete>
                            </div>
                        </div>
                    </div>
                    <div class="field is-horizontal">
                        <div class="field-label is-normal">
                            <label class="label">More Settings</label>
                        </div>
                        <div class="field-body">
                            <div class="field">
                                <b-autocomplete
                                        :data="data"
                                        placeholder="e.g. Fight Club"
                                        field="title"
                                        :loading="isFetching"
                                        @typing="getAsyncData"
                                        @select="option => selected = option">

                                    <template slot-scope="props">
                                        <div class="media">
                                            <div class="media-left">
                                                <img width="32" :src="`https://image.tmdb.org/t/p/w500/${props.option.poster_path}`">
                                            </div>
                                            <div class="media-content">
                                                {{ props.option.title }}
                                                <br>
                                                <small>
                                                    Released at {{ props.option.release_date }},
                                                    rated <b>{{ props.option.vote_average }}</b>
                                                </small>
                                            </div>
                                        </div>
                                    </template>
                                </b-autocomplete>
                            </div>
                        </div>
                    </div>
                </div>
            </b-collapse>
            <div class="field is-horizontal">
                <p class="search-horizontal-guide">Show </p>
                <b-select v-model="perPage">
                    <option
                            v-for="pp in perPageList"
                            :value="pp" :key="pp">
                        {{ pp }}
                    </option>
                </b-select>
                <p class="search-horizontal-guide">records Sort by </p>
                <b-select v-model="sortKey">
                    <option
                            v-for="ss in sortList"
                            :value="ss" :key="ss">
                        {{ ss }}
                    </option>
                </b-select>
                <b-button type="is-primary"
                          icon-left="magnify" class="search-horizontal-submit" expanded>
                    Search
                </b-button>
                <b-button type="is-default"
                          icon-left="cancel">
                    Clear
                </b-button>
            </div>
        </section>
    </div>
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
            }, 500)

        }
    }
</script>