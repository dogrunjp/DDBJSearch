<template>
  <div id="app">
    <ddbjHeader></ddbjHeader>
    <inputForm></inputForm>
    <resultTable></resultTable>
  </div>
</template>

<script>
import ddbjHeader from './components/header.vue'
import inputForm from './components/form.vue'
import resultTable from './components/result.vue'

export default {
  name: 'App',
  components: {
      ddbjHeader,
      inputForm,
      resultTable
  }
}
</script>
