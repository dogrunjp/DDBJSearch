<template>
  <main id="app">
    <div class="tabs is-centered">
      <ul>
        <template v-for="(tab, index) in tabs">
          <li :class="{'is-active': $route.path == tab.to }"  :key="index"><router-link :to="tab.to">{{ tab.label }}</router-link></li>
        </template>
      </ul>
    </div>

    <inputForm></inputForm>

    <router-view></router-view>

    <chart></chart>
  </main>
</template>

<script>
var headerTabs = [
    {
        label: 'SRA',
        name: 'sra',
        to: '/'
    },
    {
        label: 'BioProject',
        name: 'bioProject',
        to: '/bioproject'
    },
    {
        label: 'BioSample',
        name: 'bioSample',
        to: '/biosample'
    },
    {
        label: 'Taxonomy',
        name: 'taxonomy',
        to: '/taxonomy'
    },
    {
        label: 'Publication',
        name: 'publication',
        to: '/publication'
    }
]


import inputForm from './components/form.vue'
import chart from './components/chart.vue'

export default {
  name: 'App',
  data() {
      return {
          tabs : headerTabs,
      }
  },
  components: {
      inputForm,
      chart
  }
}
</script>
