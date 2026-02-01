<script setup>
const values = [
  {
    title: 'Excellence',
    description:
      'Nous visons l excellence dans chaque formation pour garantir votre réussite professionnelle.',
  },
  {
    title: 'Accompagnement',
    description:
      "Un suivi personnalisé tout au long de votre parcours, de l inscription à l insertion professionnelle.",
  },
  {
    title: 'Innovation',
    description: 'Des programmes à jour avec les dernières technologies et tendances du marché.',
  },
  {
    title: 'Accessibilité',
    description: 'La formation doit être accessible à tous, quel que soit le parcours.',
  },
]

const highlights = [
  'Centre de formation certifié Qualiopi',
  "Statut ESUS (Entreprise Sociale d'Utilité Sociale)",
  'Plus de 500 apprenants formés',
  '50+ entreprises partenaires',
]

const team = [
  {
    name: 'Benjamin Martin',
    role: 'Directeur Général',
    bio: "Fondateur de l'école, Benjamin a plus de 15 ans d'expérience dans la formation professionnelle.",
  },
  {
    name: 'Nina Dubois',
    role: 'Directrice Pédagogique',
    bio: "Experte en ingénierie pédagogique, Nina conçoit nos programmes de formation.",
  },
  {
    name: 'Tom Bernard',
    role: 'Responsable Relations Entreprises',
    bio: "Tom accompagne nos étudiants dans leur recherche d'alternance et développe notre réseau de partenaires.",
  },
  {
    name: 'Sara Petit',
    role: 'Responsable Administrative',
    bio: "Sara gère les inscriptions et accompagne les apprenants dans leurs démarches administratives.",
  },
]
</script>

<template>
  <section class="page-hero">
    <div class="page-hero-inner">
      <h1>À propos</h1>
      <p class="lead">
        Move37 Campus est un centre de formation certifié Qualiopi, dédié à l'accompagnement de
        tous ceux qui souhaitent accéder à un métier valorisant et porteur d'avenir.
      </p>
    </div>
  </section>

  <section class="section alt">
    <div class="split">
      <div>
        <h2>Notre histoire</h2>
        <p class="lead">
          Fondé en 2017, Move37 Campus est né de la volonté de rendre la formation professionnelle
          accessible à tous. Notre statut d'Entreprise Sociale d'Utilité Sociale (ESUS) témoigne de
          notre engagement envers l'inclusion et l'égalité des chances.
        </p>
        <p class="lead">
          Nous accompagnons chaque année des centaines d'apprenants dans leur reconversion ou leur
          montée en compétences, avec un taux de réussite exceptionnel et une insertion
          professionnelle rapide.
        </p>
        <ul class="list">
          <li v-for="item in highlights" :key="item">{{ item }}</li>
        </ul>
      </div>
      <div class="card">
        <h3>Notre mission</h3>
        <p>
          "Proposer un centre de formation qui accompagne toute personne souhaitant accéder à un
          métier valorisant et utile sur le marché du travail, quelle que soit son origine sociale
          ou son âge."
        </p>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="section-header">
      <h2>Nos valeurs</h2>
    </div>
    <div class="feature-grid">
      <div v-for="value in values" :key="value.title" class="feature-card">
        <h3>{{ value.title }}</h3>
        <p>{{ value.description }}</p>
      </div>
    </div>
  </section>

  <section class="section alt">
    <div class="section-header">
      <h2>Notre équipe</h2>
      <p class="section-subtitle">Des professionnels passionnés à votre service.</p>
    </div>
    <div class="team-grid">
      <div v-for="member in team" :key="member.name" class="card">
        <h3>{{ member.name }}</h3>
        <p class="team-role">{{ member.role }}</p>
        <p>{{ member.bio }}</p>
      </div>
    </div>
  </section>

  <section class="cta">
    <div class="cta-inner">
      <div>
        <h2>Rejoignez-nous</h2>
        <p class="lead">Découvrez nos formations et commencez votre parcours vers une nouvelle carrière.</p>
      </div>
      <div class="cta-actions">
        <RouterLink class="btn primary" to="/catalogue">Voir nos formations</RouterLink>
        <RouterLink class="btn ghost" to="/contact">Nous contacter</RouterLink>
      </div>
    </div>
  </section>
</template>
