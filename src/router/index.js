import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/Home.vue'
import Diary from '../pages/Diary.vue'
import NewEntry from '../pages/NewEntry.vue'
import Stats from '../pages/Stats.vue'

const routes = [
  { path: '/', component: Home, name: 'Home' },
  { path: '/diary', component: Diary, name: 'Diary' },
  { path: '/new', component: NewEntry, name: 'NewEntry' },
  { path: '/stats', component: Stats, name: 'Stats' }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
