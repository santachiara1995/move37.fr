<script setup>
import { RouterLink, RouterView } from 'vue-router'

const navLinks = [
  { label: 'Accueil', to: '/' },
  { label: 'Nos formations', to: '/catalogue' },
  { label: 'Devenir alternant', to: '/devenir-alternant' },
  { label: 'Espace entreprise', to: '/recrutements' },
  { label: 'À propos', to: '/a-propos' },
]
</script>

<template>
  <div class="page" id="top">
    <header class="nav">
      <div class="nav-inner">
        <RouterLink class="brand" to="/">Move37 Campus</RouterLink>
        <nav class="nav-links">
          <RouterLink v-for="link in navLinks" :key="link.label" :to="link.to">
            {{ link.label }}
          </RouterLink>
        </nav>
        <div class="nav-actions">
          <RouterLink class="btn ghost" to="/">Accueil</RouterLink>
          <RouterLink class="link" to="/contact">Contact</RouterLink>
          <RouterLink class="btn primary" to="/connexion">Connexion</RouterLink>
        </div>
      </div>
    </header>

    <main>
      <RouterView />
    </main>

    <footer class="footer">
      <div class="footer-grid">
        <div>
          <div class="brand">Move37 Campus</div>
          <p>Centre de formation certifié Qualiopi</p>
        </div>
        <div>
          <div class="footer-title">Formations</div>
          <div class="footer-links">
            <RouterLink to="/catalogue">Toutes les formations</RouterLink>
            <RouterLink to="/devenir-alternant">Alternance</RouterLink>
          </div>
        </div>
        <div>
          <div class="footer-title">Entreprises</div>
          <div class="footer-links">
            <RouterLink to="/recrutements">Recruter un alternant</RouterLink>
            <RouterLink to="/contact">Nous contacter</RouterLink>
          </div>
        </div>
        <div>
          <div class="footer-title">Contact</div>
          <div class="footer-links">
            <span>contact@move37.fr</span>
            <span>09 77 21 51 61</span>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>© 2026 Move37 Campus</p>
        <div class="footer-links">
          <a href="#">Mentions légales</a>
          <a href="#">Confidentialité</a>
        </div>
      </div>
    </footer>
  </div>
</template>
