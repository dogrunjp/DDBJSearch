<template>
  <main id="app">
    <div class="tabs is-centered">
      <ul>
        <li><a href="http://sra-demo.bmu.jp/">SRA</a></li>
        <template v-for="(rt, index) in items">
            <li v-show="rt.show" :class="{'is-active': $route.path == rt.path }" :key="index">
                <router-link :to="rt.path">{{ rt.label }}</router-link>
            </li>
        </template>
      </ul>
    </div>

    <inputForm></inputForm>

    <router-view></router-view>

    <!--  <chart></chart> -->
  </main>
</template>

<script>
import inputForm from './components/form.vue'
//import chart from './components/chart.vue'

export default {
  name: 'App',
  data() {
      return {
          items: []
      }
  },
  created() {
        this.$router.options.routes.forEach(route => {
            this.items.push({
            label: route.label, path: route.path, show: route.show,
        })
    })
  },
  components: {
      inputForm,
      // chart
  }
}
</script>
