import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)
Vue.config.productionTip = true

import buefy from 'buefy'
Vue.use(buefy)

// import './config'
import App from './App.vue'
import Sra from './components/result_sra.vue'
import BioProject from './components/result_bioproject.vue'
import BioSample from './components/result_biosample.vue'
import Taxonomy from './components/result_taxonomy.vue'
import Publication from './components/result_publication.vue'


const routes = [
    { path: '/', component: Sra, name: 'sra' },
    { path: '/bioproject', component: BioProject, name: 'bioproject' },
    { path: '/biosample', component: BioSample, name: 'biosample' },
    { path: '/taxonomy', component: Taxonomy, name: 'taxonomy' },
    { path: '/publication', component: Publication, name:'publication' }
]

const router = new VueRouter({
    routes
})

new Vue({
    router,
    render: h => h(App),
}).$mount('#app')
