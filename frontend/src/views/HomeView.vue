<script setup>
const features = [
  {
    title: 'Diplômes reconnus',
    description:
      "Titres professionnels RNCP reconnus par l'Etat et valorisés par les entreprises.",
  },
  {
    title: 'Accompagnement personnalisé',
    description: 'Un tuteur dédié vous accompagne tout au long de votre parcours de formation.',
  },
  {
    title: 'Rythme adapté',
    description: 'Alternance 4 jours entreprise / 1 jour formation, ou formation continue flexible.',
  },
]

const courses = [
  {
    title: 'Développeur Intelligence Artificielle',
    shortDescription:
      "Maîtrisez les fondamentaux du développement IA et du Machine Learning pour créer des solutions innovantes.",
    duration: '12 mois',
    alternance: true,
    cpf: true,
  },
  {
    title: 'Data Analyst',
    shortDescription:
      'Transformez les données en insights stratégiques pour guider la prise de décision en entreprise.',
    duration: '9 mois',
    alternance: true,
    cpf: true,
  },
  {
    title: 'Prompt Engineering & IA Générative',
    shortDescription:
      "Maîtrisez l'art du prompt engineering pour exploiter pleinement les LLMs comme ChatGPT et Claude.",
    duration: '3 mois',
    alternance: false,
    cpf: true,
  },
]

const stats = [
  { value: '500+', label: 'Apprenants formés' },
  { value: '95%', label: 'Taux de réussite' },
  { value: '85%', label: 'Insertion pro' },
  { value: '50+', label: 'Partenaires' },
]

const testimonials = [
  {
    name: 'Marie L.',
    role: 'Développeur IA Junior',
    quote:
      "Grâce à cette formation en alternance, j'ai pu acquérir des compétences concrètes en intelligence artificielle tout en étant rémunérée. L'accompagnement pédagogique était excellent.",
  },
  {
    name: 'Thomas D.',
    role: 'Data Analyst',
    quote:
      "La formation Data Analyst m'a permis de me reconvertir complètement. Les formateurs sont à l'écoute et les projets pratiques m'ont vraiment préparé au monde professionnel.",
  },
  {
    name: 'Sarah M.',
    role: 'Commerciale B2B',
    quote:
      "J'ai choisi la formation en alternance pour le commerce et c'était le meilleur choix. 4 jours en entreprise m'ont permis d'apprendre directement sur le terrain.",
  },
]
</script>

<template>
  <section class="hero">
    <div class="hero-inner">
      <div class="hero-content">
        <h1>Formez-vous aux métiers de demain.</h1>
        <p class="lead">
          Centre de formation certifié Qualiopi. Formations en alternance ou en continu,
          dans le numérique et l'intelligence artificielle.
        </p>
        <div class="hero-actions">
          <RouterLink class="btn primary" to="/catalogue">Découvrir nos formations</RouterLink>
          <RouterLink class="btn ghost" to="/devenir-alternant">Devenir alternant</RouterLink>
        </div>
      </div>
      <div class="hero-card">
        <div class="hero-panel">
          <div class="panel-title">Diplômes reconnus</div>
          <p>
            Titres professionnels RNCP reconnus par l'Etat et valorisés par les entreprises.
          </p>
          <div class="panel-tags">
            <span>RNCP</span>
            <span>CPF</span>
            <span>Alternance</span>
          </div>
        </div>
        <div class="hero-panel highlight">
          <div class="panel-title">Accompagnement personnalisé</div>
          <p>Un tuteur dédié vous accompagne tout au long de votre parcours.</p>
          <div class="progress">
            <div class="progress-bar" />
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="certs" id="alternance">
    <div class="certs-inner">
      <div class="cert">Certifié Qualiopi</div>
      <div class="cert">Titres RNCP</div>
      <div class="cert">Éligible CPF</div>
    </div>
  </section>

  <section class="section" id="apropos">
    <div class="section-header">
      <h2>Pourquoi nous choisir</h2>
    </div>
    <div class="feature-grid">
      <div v-for="feature in features" :key="feature.title" class="feature-card">
        <h3>{{ feature.title }}</h3>
        <p>{{ feature.description }}</p>
      </div>
    </div>
  </section>

  <section class="section alt" id="formations">
    <div class="section-header">
      <h2>Nos formations</h2>
      <p class="section-subtitle">
        Des programmes certifiants pour les métiers les plus recherchés
      </p>
    </div>
    <div class="course-grid">
      <article v-for="course in courses" :key="course.title" class="course-card">
        <div class="course-tags">
          <span v-if="course.alternance">Alternance</span>
          <span v-if="course.cpf">CPF</span>
        </div>
        <h3>{{ course.title }}</h3>
        <p>{{ course.shortDescription }}</p>
        <div class="course-meta">{{ course.duration }}</div>
      </article>
    </div>
    <div class="section-actions">
      <RouterLink class="btn ghost" to="/catalogue">Voir toutes les formations</RouterLink>
    </div>
  </section>

  <section class="section" id="entreprises">
    <div class="stats-grid">
      <div v-for="stat in stats" :key="stat.label" class="stat-card">
        <div class="stat-value">{{ stat.value }}</div>
        <div class="stat-label">{{ stat.label }}</div>
      </div>
    </div>
  </section>

  <section class="section alt" id="temoignages">
    <div class="section-header">
      <h2>Ce qu'ils en disent</h2>
    </div>
    <div class="testimonial-grid">
      <figure v-for="quote in testimonials" :key="quote.name" class="testimonial-card">
        <blockquote>"{{ quote.quote }}"</blockquote>
        <figcaption>
          <strong>{{ quote.name }}</strong>
          <span>{{ quote.role }}</span>
        </figcaption>
      </figure>
    </div>
  </section>

  <section class="cta" id="contact">
    <div class="cta-inner">
      <div>
        <h2>Prêt à vous lancer ?</h2>
        <p class="lead">Contactez-nous pour en savoir plus sur nos formations.</p>
      </div>
      <div class="cta-actions">
        <RouterLink class="btn primary" to="/contact">Nous contacter</RouterLink>
        <RouterLink class="btn ghost" to="/catalogue">Voir les formations</RouterLink>
      </div>
    </div>
  </section>
</template>
