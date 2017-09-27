<template>
<div>
  <color-bank v-for="bank in banks" v-bind:bank="bank" v-bind:key="bank.name"/>
</div>
</template>

<script>
import Bank from '@/components/Bank'
import axios from 'axios'

export default {
  components: {
    'color-bank': Bank
  },
  data () {
    return {
      banks: []
    }
  },
  created () {
    axios.get('/api/banks')
    .then(response => {
      this.banks = response.data
    })
  }
}
</script>

<style scoped>
</style>
