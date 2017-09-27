<template>
<div class="bank">
  <h2>Bank {{ bank.name }}</h2>
  <color-picker :value="colors" @input="updateValue" />
</div>
</template>

<script>
import { Slider } from 'vue-color'
import axios from 'axios'

export default {
  props: ['bank'],
  components: {
    'color-picker': Slider
  },
  created () {
    this.colors = {
      r: this.bank.rgb[0],
      g: this.bank.rgb[1],
      b: this.bank.rgb[2]
    }

    console.log(this.colors)
  },
  beforeCreate () {
    console.log('foo')
  },
  methods: {
    updateValue (value) {
      this.colors = value.rgba
      axios.put('/api/bank/' + this.bank.name,
        [ this.colors.r, this.colors.g, this.colors.b ])
      console.log(this.colors)
    }
  }
}
</script>

<style scoped>
</style>
