import Vue from 'vue'
import Router from 'vue-router'
import Banks from '@/components/Banks'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Banks',
      component: Banks
    }
  ]
})
