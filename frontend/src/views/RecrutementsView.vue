<script setup>
const advantages = [
  {
    title: 'Talents qualifiés',
    description: 'Accès à un vivier de candidats motivés et formés aux compétences recherchées.',
  },
  {
    title: 'Gestion simplifiée',
    description: 'Nous prenons en charge toutes les démarches administratives liées au contrat.',
  },
  {
    title: 'Suivi pédagogique',
    description: "Un accompagnement régulier de l'alternant avec des bilans tripartites.",
  },
  {
    title: 'Partenariat durable',
    description: 'Développez une relation de confiance pour vos futurs recrutements.',
  },
]

const services = [
  {
    title: "Recrutement d'alternants",
    description:
      'Nous vous aidons à trouver le profil idéal parmi nos apprenants pour répondre à vos besoins.',
    features: ['Présélection des candidats', 'Matching profil/poste', 'Accompagnement administratif'],
  },
  {
    title: 'Formation sur-mesure',
    description:
      'Concevez des programmes de formation adaptés aux besoins spécifiques de votre entreprise.',
    features: ['Analyse des besoins', 'Programme personnalisé', 'Formateurs experts'],
  },
  {
    title: 'Formation continue',
    description:
      "Formez vos collaborateurs aux nouvelles compétences du numérique et de l'IA.",
    features: ['Éligible CPF/OPCO', 'Formats flexibles', 'Certifications reconnues'],
  },
]

const steps = [
  {
    number: '1',
    title: 'Exprimez votre besoin',
    description: 'Contactez-nous pour nous faire part de vos besoins en recrutement ou formation.',
  },
  {
    number: '2',
    title: 'Nous sélectionnons',
    description: 'Notre équipe identifie les profils correspondant à vos critères.',
  },
  {
    number: '3',
    title: 'Vous recrutez',
    description: 'Rencontrez les candidats et choisissez votre futur collaborateur.',
  },
  {
    number: '4',
    title: 'Nous accompagnons',
    description: "Suivi pédagogique et administratif tout au long du contrat.",
  },
]

const stats = [
  { value: '50+', label: 'Entreprises partenaires' },
  { value: '200+', label: 'Alternants placés' },
  { value: '95%', label: 'Satisfaction entreprise' },
  { value: '85%', label: 'Embauche post-alternance' },
]
</script>

<template>
  <section class="page-hero">
    <div class="page-hero-inner">
      <h1>Espace entreprise</h1>
      <p class="lead">
        Recrutez des talents formés aux compétences de demain. Nous vous accompagnons dans le
        recrutement d'alternants et la formation de vos équipes.
      </p>
      <div class="hero-actions">
        <RouterLink class="btn primary" to="/contact">Recruter un alternant</RouterLink>
        <RouterLink class="btn ghost" to="/contact">Former mes équipes</RouterLink>
      </div>
    </div>
  </section>

  <section class="section alt">
    <div class="section-header">
      <h2>Pourquoi nous faire confiance ?</h2>
    </div>
    <div class="feature-grid">
      <div v-for="advantage in advantages" :key="advantage.title" class="feature-card">
        <h3>{{ advantage.title }}</h3>
        <p>{{ advantage.description }}</p>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="section-header">
      <h2>Nos services aux entreprises</h2>
    </div>
    <div class="service-grid">
      <div v-for="service in services" :key="service.title" class="card">
        <h3>{{ service.title }}</h3>
        <p>{{ service.description }}</p>
        <ul class="list">
          <li v-for="item in service.features" :key="item">{{ item }}</li>
        </ul>
      </div>
    </div>
  </section>

  <section class="section alt">
    <div class="section-header">
      <h2>Comment recruter ?</h2>
      <p class="section-subtitle">Un processus simple et accompagné.</p>
    </div>
    <div class="steps-grid">
      <div v-for="step in steps" :key="step.number" class="step-card">
        <div class="step-number">{{ step.number }}</div>
        <h3>{{ step.title }}</h3>
        <p>{{ step.description }}</p>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="stats-grid">
      <div v-for="stat in stats" :key="stat.label" class="stat-card">
        <div class="stat-value">{{ stat.value }}</div>
        <div class="stat-label">{{ stat.label }}</div>
      </div>
    </div>
  </section>

  <section class="cta">
    <div class="cta-inner">
      <div>
        <h2>Prêt à recruter vos futurs talents ?</h2>
        <p class="lead">Contactez-nous pour discuter de vos besoins.</p>
      </div>
      <div class="cta-actions">
        <RouterLink class="btn primary" to="/contact">Contacter notre équipe</RouterLink>
        <RouterLink class="btn ghost" to="/catalogue">Voir les formations</RouterLink>
      </div>
    </div>
  </section>
</template>
