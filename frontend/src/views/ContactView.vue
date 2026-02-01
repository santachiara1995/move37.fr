<script setup>
import { ref } from 'vue'

const isSubmitted = ref(false)
const isSubmitting = ref(false)

const handleSubmit = async () => {
  isSubmitting.value = true
  await new Promise((resolve) => setTimeout(resolve, 800))
  isSubmitting.value = false
  isSubmitted.value = true
}
</script>

<template>
  <section class="page-hero">
    <div class="page-hero-inner">
      <h1>Contactez-nous</h1>
      <p class="lead">Une question ? Notre équipe est à votre disposition.</p>
    </div>
  </section>

  <section class="section">
    <div class="contact-grid">
      <div class="card">
        <h2>Nos coordonnées</h2>
        <p class="lead">contact@move37.fr</p>
        <p class="lead">09 77 21 51 61</p>
        <p class="lead">1 Rue Galvani, 91300 Massy</p>
      </div>

      <div class="card">
        <h2>Écrivez-nous</h2>
        <form class="form" @submit.prevent="handleSubmit">
          <div class="form-row">
            <div>
              <label>Prénom</label>
              <input class="input" type="text" required placeholder="Votre prénom" />
            </div>
            <div>
              <label>Nom</label>
              <input class="input" type="text" required placeholder="Votre nom" />
            </div>
          </div>
          <div class="form-row">
            <div>
              <label>Email</label>
              <input class="input" type="email" required placeholder="votre@email.com" />
            </div>
            <div>
              <label>Téléphone</label>
              <input class="input" type="tel" required placeholder="06 00 00 00 00" />
            </div>
          </div>
          <div>
            <label>Sujet</label>
            <select class="input" required>
              <option value="">Sélectionnez un sujet</option>
              <option value="formation">Renseignements formation</option>
              <option value="alternance">Candidature alternance</option>
              <option value="entreprise">Espace entreprise</option>
              <option value="autre">Autre demande</option>
            </select>
          </div>
          <div>
            <label>Message</label>
            <textarea class="input" rows="5" required placeholder="Votre message..." />
          </div>
          <button class="btn primary" type="submit" :disabled="isSubmitting">
            {{ isSubmitting ? 'Envoi en cours...' : 'Envoyer' }}
          </button>
          <p v-if="isSubmitted" class="form-success">Message envoyé. Nous vous répondons rapidement.</p>
        </form>
      </div>
    </div>
  </section>
</template>
