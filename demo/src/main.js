import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import buefy from 'buefy'
Vue.use(buefy)

// import './config'
import App from './App.vue'

Vue.config.productionTip = false


// 1. ルートコンポーネントを定義します
// 他のファイルからインポートすることもできます
//const taxonomy = { template: '<div>taxonomy</div>' }
//const publication = { template: '<div>publication</div>' }

// 2. ルートをいくつか定義します
// 各ルートは 1 つのコンポーネントとマッピングされる必要があります。
// このコンポーネントは実際の `Vue.extend()`、
// またはコンポーネントオプションのオブジェクトでも構いません。
// ネストされたルートに関しては後で説明します
const routes = [
    { path: '/taxonomy' },
    { path: '/publication' }
]

// 3. ルーターインスタンスを作成して、ルートオプションを渡します
// 追加のオプションをここで指定できますが、
// この例ではシンプルにしましょう
const router = new VueRouter({
    routes // `routes: routes` の短縮表記
})

// 4. root となるインスタンスを作成してマウントします
// アプリケーション全体がルーターを認知できるように、
// ルーターをインジェクトすることを忘れないでください。
new Vue({
    router,
    render: h => h(App),
}).$mount('#app')
