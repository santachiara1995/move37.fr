<script setup>
import { ref } from 'vue'

const isLoading = ref(false)
const showPassword = ref(false)

const handleSubmit = async () => {
  isLoading.value = true
  await new Promise((resolve) => setTimeout(resolve, 800))
  isLoading.value = false
}
</script>

<template>
  <section class="page-hero">
    <div class="page-hero-inner">
      <h1>Connexion</h1>
      <p class="lead">Accédez à votre espace apprenant.</p>
    </div>
  </section>

  <section class="section">
    <div class="login-card">
      <h2>Se connecter</h2>
      <form class="form" @submit.prevent="handleSubmit">
        <div>
          <label>Adresse email</label>
          <input class="input" type="email" required placeholder="votre@email.com" />
        </div>
        <div>
          <label>Mot de passe</label>
          <div class="password-row">
            <input
              class="input"
              :type="showPassword ? 'text' : 'password'"
              required
              placeholder="Votre mot de passe"
            />
            <button class="btn ghost" type="button" @click="showPassword = !showPassword">
              {{ showPassword ? 'Masquer' : 'Afficher' }}
            </button>
          </div>
        </div>
        <button class="btn primary" type="submit" :disabled="isLoading">
          {{ isLoading ? 'Connexion...' : 'Se connecter' }}
        </button>
      </form>
      <p class="login-note">
        Accédez à la plateforme en ligne :
        <a
          href="https://cityzformation.agora-learning.com/learning-space?token=jSaorf-kCtJnQaD9rrqAMV2TTjuu2sW461IGamwWLXUZOHY3xH39PvoyXh7x8i9T4e6cRv6IPGmdBsKr5ga30Dn9oazp6MiGmE1USkslSGT-6fmCKkfI7m-rrJeXvy-J"
          target="_blank"
          rel="noreferrer"
        >
          Ouvrir l'espace apprenant
        </a>
      </p>
    </div>
  </section>
</template>
