<script setup>
const benefits = [
  {
    title: 'Formation financée',
    description: 'Aucun frais de scolarité. Votre formation est entièrement prise en charge.',
  },
  {
    title: 'Expérience professionnelle',
    description: '4 jours en entreprise par semaine pour acquérir une expérience concrète.',
  },
  {
    title: 'Diplôme reconnu',
    description: "Titre professionnel RNCP reconnu par l'Etat et valorisé sur le marché.",
  },
  {
    title: 'Accompagnement complet',
    description: 'Un tuteur dédié vous accompagne tout au long de votre parcours.',
  },
]

const steps = [
  {
    number: '01',
    title: 'Choisissez votre formation',
    description: 'Explorez notre catalogue et sélectionnez la formation adaptée à votre projet.',
  },
  {
    number: '02',
    title: 'Candidatez en ligne',
    description: 'Remplissez le formulaire et transmettez-nous votre CV et lettre de motivation.',
  },
  {
    number: '03',
    title: "Entretien d'admission",
    description: 'Rencontrez notre équipe pour valider votre projet et votre motivation.',
  },
  {
    number: '04',
    title: 'Trouvez votre entreprise',
    description: 'Nous vous accompagnons dans votre recherche grâce à notre réseau.',
  },
  {
    number: '05',
    title: 'Signez votre contrat',
    description: 'Finalisez les démarches et démarrez votre aventure en alternance.',
  },
]

const documents = [
  'CV actualisé avec photo',
  'Lettre de motivation',
  'Copies des diplômes obtenus',
  "Copie de la pièce d'identité",
  'Attestation de sécurité sociale',
  'Justificatif de domicile',
]

const alternanceCourses = [
  'Développeur Intelligence Artificielle',
  'Data Analyst',
  'Négociateur Technico-Commercial',
  'Assistant Ressources Humaines',
  'Développeur Web Full Stack',
]
</script>

<template>
  <section class="page-hero">
    <div class="page-hero-inner">
      <h1>Devenez alternant</h1>
      <p class="lead">
        L'alternance est le format idéal pour apprendre un métier tout en étant rémunéré.
        Combinez théorie et pratique avec 4 jours en entreprise et 1 jour de formation.
      </p>
      <div class="hero-actions">
        <RouterLink class="btn primary" to="/contact">Candidater maintenant</RouterLink>
        <RouterLink class="btn ghost" to="/catalogue">Voir les formations</RouterLink>
      </div>
    </div>
  </section>

  <section class="section alt">
    <div class="section-header">
      <h2>Les avantages de l'alternance</h2>
    </div>
    <div class="feature-grid">
      <div v-for="benefit in benefits" :key="benefit.title" class="feature-card">
        <h3>{{ benefit.title }}</h3>
        <p>{{ benefit.description }}</p>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="section-header">
      <h2>Comment ça marche ?</h2>
      <p class="section-subtitle">5 étapes simples pour démarrer votre alternance.</p>
    </div>
    <div class="steps-grid">
      <div v-for="step in steps" :key="step.number" class="step-card">
        <div class="step-number">{{ step.number }}</div>
        <h3>{{ step.title }}</h3>
        <p>{{ step.description }}</p>
      </div>
    </div>
  </section>

  <section class="section alt">
    <div class="section-header">
      <h2>Documents à fournir</h2>
      <p class="section-subtitle">
        Pour finaliser votre candidature, préparez les documents suivants.
      </p>
    </div>
    <div class="card">
      <ul class="list">
        <li v-for="doc in documents" :key="doc">{{ doc }}</li>
      </ul>
    </div>
  </section>

  <section class="section">
    <div class="section-header">
      <h2>Formations en alternance</h2>
      <p class="section-subtitle">Découvrez nos parcours accessibles en alternance.</p>
    </div>
    <div class="tag-grid">
      <span v-for="course in alternanceCourses" :key="course" class="tag-chip">
        {{ course }}
      </span>
    </div>
  </section>

  <section class="cta">
    <div class="cta-inner">
      <div>
        <h2>Prêt à vous lancer ?</h2>
        <p class="lead">Candidatez dès maintenant pour rejoindre l'alternance.</p>
      </div>
      <div class="cta-actions">
        <RouterLink class="btn primary" to="/contact">Candidater à l'alternance</RouterLink>
        <RouterLink class="btn ghost" to="/catalogue">Voir les formations</RouterLink>
      </div>
    </div>
  </section>
</template>
