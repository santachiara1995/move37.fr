import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import CatalogueView from '../views/CatalogueView.vue'
import AlternantView from '../views/AlternantView.vue'
import RecrutementsView from '../views/RecrutementsView.vue'
import AproposView from '../views/AproposView.vue'
import ContactView from '../views/ContactView.vue'
import ConnexionView from '../views/ConnexionView.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', name: 'home', component: HomeView },
    { path: '/catalogue', name: 'catalogue', component: CatalogueView },
    { path: '/devenir-alternant', name: 'alternant', component: AlternantView },
    { path: '/recrutements', name: 'recrutements', component: RecrutementsView },
    { path: '/a-propos', name: 'apropos', component: AproposView },
    { path: '/contact', name: 'contact', component: ContactView },
    { path: '/connexion', name: 'connexion', component: ConnexionView },
  ],
  scrollBehavior() {
    return { top: 0 }
  },
})

export default router
