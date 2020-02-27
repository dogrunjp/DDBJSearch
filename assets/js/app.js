var header = new Vue ({
    el: 'header',
    data() {
        return {
            activeTab: 3,
            tabs : headerTabs,
        }
    }
})

var search = new Vue({
    el: "#search",
    data() {
        return {
            data: [],
            selected: null,
            isFetching: false,
            sortKey : 'ASSOCIATION',
            sortList : [
                'ASSOCIATION','OTHER','OTHER'
            ],
            perPage : 10,
            perPageList : [
                10,20,30
            ]
        }
    },
    methods: {
        // You have to install and import debounce to use it,
        // it's not mandatory though.
        getAsyncData: _.debounce(function (name) {
            if (!name.length) {
                this.data = []
                return
            }
            this.isFetching = true
            axios.get(`https://api.themoviedb.org/3/search/movie?api_key=bb6f51bef07465653c3e553d6ab161a8&query=${name}`)
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
})


var result = new Vue ({
    el: '#result',
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
})
