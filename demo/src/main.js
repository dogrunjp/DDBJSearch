import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)
Vue.config.productionTip = true

import buefy from 'buefy'
Vue.use(buefy)

import App from './App.vue'
import Sra from './components/result_sra.vue'
import BioProject from './components/result_bioproject.vue'
import BioSample from './components/result_biosample.vue'
import Taxonomy from './components/result_taxonomy.vue'
import Publication from './components/result_publication.vue'

const base_api = 'http://13.113.107.2/api/'

const routes = [
    {
        path: '/sra',
        component: Sra,
        name: 'sra',
        label: 'SRA',
        show: false,
        props: (route) => ({
            assesions: route.query.assesions,
            keyword: route.query.keyword,
            sra_title: route.query.sra_title,
            publication_id: route.query.publication_id,
            studytype_id: route.query.studytype_id,
            library_name: route.query.library_name,
            library_strategy: route.query.library_strategy,
            library_source: route.query.library_source,
            library_selection: route.query.library_selection,
            platform: route.query.platform,
            instrument_model: route.query.instrument_model,
            per_page: route.query.per_page,
            sort_key: route.query.sort_key,
            page_no: route.query.page_no
        })
    },
    {
        path: '/bioproject',
        component: BioProject,
        name: 'bioproject',
        label: 'BioProject',
        show: false,
        props: (route) => ({
            assesions: route.query.assesions,
            keyword: route.query.keyword,
            bioproject_title: route.query.bioproject_title,
            bp_publication_id: route.query.bp_publication_id,
            per_page: route.query.per_page,
            sort_key: route.query.sort_key,
            page_no: route.query.page_no
        })
    },
    {
        path: '/biosample',
        component: BioSample,
        name: 'biosample',
        label: 'BioSample',
        show: false,
        props: (route) => ({
            assesions: route.query.assesions,
            keyword: route.query.keyword,
            bs_taxonomy_id: route.query.bs_taxonomy_id,
            bs_organism_name: route.query.bs_organism_name,
            bs_title: route.query.bs_title,
            package: route.query.package,
            per_page: route.query.per_page,
            sort_key: route.query.sort_key,
            page_no: route.query.page_no
        })
    },
    {
        path: '/',
        component: Taxonomy,
        name: 'taxonomy',
        label: 'Taxonomy',
        show: true,
        props: (route) => ({
            tx_taxonomy_id: route.query.tx_taxonomy_id,
            scientific_name: route.query.scientific_name,
            per_page: route.query.per_page,
            page_no: route.query.page_no,
            sort_key: route.query.sort_key,
            order_by: route.query.order_by,
        }),
        meta: {
            apiUrl_taxonomy: base_api + 'exp_taxonomy/',
            apiUrl_scientific_name: base_api + 'scientific_name/',
            apiUrl_get_tax_name: base_api + 'taxonomyid/',
            apiUrl_get_name_tax: base_api + 'scientific_name/',
            linkUrl_biosample: 'http://sra-demo.bmu.jp/result.html?target_db=biosample&rows=20&taxonomy_id=',
            sortList: ['TaxonomyID', 'ScientificName'],
        }
    },
    {
        path: '/publication',
        component: Publication,
        name:'publication',
        label: 'Publication',
        show: true,
        props: (route) => ({
            journal: route.query.journal,
            article_title: route.query.article_title,
            bp_title: route.query.pub_bp_title,
            pub_year: route.query.pub_year,
            per_page: route.query.per_page,
            page_no: route.query.page_no,
            sort_key: route.query.sort_key,
            order_by: route.query.order_by,
        }),
        meta: {
            apiUrl: 'http://dbcls-sra-api.bmu.jp/api/publication/search',
            sortList: ['BioProject', 'PMID'],
        }
    }
]

const router = new VueRouter({
    mode: 'history',
    routes
})

new Vue({
    router,
    render: h => h(App),
}).$mount('#app')
