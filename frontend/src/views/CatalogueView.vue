<script setup>
const courses = [
  {
    title: 'Développeur Intelligence Artificielle',
    shortDescription:
      "Maîtrisez les fondamentaux du développement IA et du Machine Learning pour créer des solutions innovantes.",
    duration: '12 mois',
    level: 'Intermédiaire',
    alternance: true,
    cpf: true,
    rncp: 'RNCP37873',
  },
  {
    title: 'Data Analyst',
    shortDescription:
      'Transformez les données en insights stratégiques pour guider la prise de décision en entreprise.',
    duration: '9 mois',
    level: 'Débutant',
    alternance: true,
    cpf: true,
    rncp: 'RNCP34964',
  },
  {
    title: 'Prompt Engineering & IA Générative',
    shortDescription:
      "Maîtrisez l'art du prompt engineering pour exploiter pleinement les LLMs comme ChatGPT et Claude.",
    duration: '3 mois',
    level: 'Débutant',
    alternance: false,
    cpf: true,
  },
  {
    title: 'Négociateur Technico-Commercial',
    shortDescription:
      'Développez vos compétences en vente B2B et négociation pour exceller dans le commerce.',
    duration: '12 mois',
    level: 'Débutant',
    alternance: true,
    cpf: true,
    rncp: 'RNCP34079',
  },
  {
    title: 'Assistant Ressources Humaines',
    shortDescription:
      "Formez-vous aux métiers des RH et accompagnez les entreprises dans leur gestion du capital humain.",
    duration: '10 mois',
    level: 'Débutant',
    alternance: true,
    cpf: true,
    rncp: 'RNCP35030',
  },
  {
    title: 'Développeur Web Full Stack',
    shortDescription:
      'Maîtrisez le développement front-end et back-end pour créer des applications web complètes.',
    duration: '12 mois',
    level: 'Intermédiaire',
    alternance: true,
    cpf: true,
    rncp: 'RNCP37674',
  },
]
</script>

<template>
  <section class="page-hero">
    <div class="page-hero-inner">
      <h1>Nos formations</h1>
      <p class="lead">
        Des programmes certifiants éligibles CPF, en alternance ou en formation continue.
      </p>
    </div>
  </section>

  <section class="section">
    <div class="course-grid">
      <article v-for="course in courses" :key="course.title" class="course-card">
        <div class="course-tags">
          <span v-if="course.alternance">Alternance</span>
          <span v-if="course.cpf">CPF</span>
          <span v-if="course.rncp">RNCP</span>
        </div>
        <h3>{{ course.title }}</h3>
        <p>{{ course.shortDescription }}</p>
        <div class="course-meta">{{ course.duration }} · {{ course.level }}</div>
      </article>
    </div>
  </section>

  <section class="section alt">
    <div class="section-header">
      <h2>Un parcours professionnalisant</h2>
      <p class="section-subtitle">
        Projets concrets, évaluations continues et accompagnement pédagogique tout au long du
        parcours.
      </p>
    </div>
  </section>

  <section class="cta">
    <div class="cta-inner">
      <div>
        <h2>Besoin d'aide pour choisir ?</h2>
        <p class="lead">Parlez à un conseiller pour identifier la formation adaptée.</p>
      </div>
      <div class="cta-actions">
        <RouterLink class="btn primary" to="/contact">Parler à un conseiller</RouterLink>
        <RouterLink class="btn ghost" to="/devenir-alternant">Découvrir l'alternance</RouterLink>
      </div>
    </div>
  </section>
</template>
