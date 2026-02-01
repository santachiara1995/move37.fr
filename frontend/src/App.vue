<script setup>
const stats = [
  { value: '500+', label: 'Apprenants formes' },
  { value: '95%', label: 'Taux de reussite' },
  { value: '85%', label: 'Insertion pro' },
  { value: '50+', label: 'Partenaires' },
]

const courses = [
  {
    title: 'Developpeur Intelligence Artificielle',
    description:
      'Maitrisez les fondamentaux du developpement IA et du Machine Learning pour creer des solutions innovantes.',
    duration: '12 mois',
    alternance: true,
    cpf: true,
  },
  {
    title: 'Data Analyst',
    description:
      'Transformez les donnees en insights strategiques pour guider la prise de decision en entreprise.',
    duration: '9 mois',
    alternance: true,
    cpf: true,
  },
  {
    title: 'Prompt Engineering & IA Generative',
    description:
      "Maitrisez l'art du prompt engineering pour exploiter pleinement les LLMs comme ChatGPT et Claude.",
    duration: '3 mois',
    alternance: false,
    cpf: true,
  },
]

const testimonials = [
  {
    name: 'Marie L.',
    role: 'Developpeur IA Junior',
    quote:
      "Grace a cette formation en alternance, j'ai pu acquerir des competences concretes en intelligence artificielle tout en etant remunere. L'accompagnement pedagogique etait excellent.",
  },
  {
    name: 'Thomas D.',
    role: 'Data Analyst',
    quote:
      "La formation Data Analyst m'a permis de me reconvertir completement. Les formateurs sont a l'ecoute et les projets pratiques m'ont vraiment prepare au monde professionnel.",
  },
  {
    name: 'Sarah M.',
    role: 'Commerciale B2B',
    quote:
      "J'ai choisi la formation en alternance pour le commerce et c'etait le meilleur choix. 4 jours en entreprise m'ont permis d'apprendre directement sur le terrain.",
  },
]
</script>

<template>
  <div class="page" id="top">
    <header class="nav">
      <div class="nav-inner">
        <a class="brand" href="#top">Move37 Campus</a>
        <nav class="nav-links">
          <a href="#formations">Formations</a>
          <a href="#alternance">Alternance</a>
          <a href="#entreprises">Entreprises</a>
          <a href="#apropos">A propos</a>
        </nav>
        <div class="nav-actions">
          <a class="btn ghost" href="#top">Accueil</a>
          <a class="link" href="#contact">Contact</a>
          <a class="btn primary" href="/connexion">Connexion</a>
        </div>
      </div>
    </header>

    <main>
      <section class="hero">
        <div class="hero-inner">
          <div class="hero-content">
            <h1>Formez-vous aux metiers de demain.</h1>
            <p class="lead">
              Centre de formation certifie Qualiopi. Formations en alternance ou en continu,
              dans le numerique et l'intelligence artificielle.
            </p>
            <div class="hero-actions">
              <a class="btn primary" href="#formations">Decouvrir nos formations</a>
              <a class="btn ghost" href="#alternance">Devenir alternant</a>
            </div>
          </div>
          <div class="hero-card">
            <div class="hero-panel">
              <div class="panel-title">Diplomes reconnus</div>
              <p>Titres professionnels RNCP reconnus par l'Etat et valorises par les entreprises.</p>
              <div class="panel-tags">
                <span>RNCP</span>
                <span>CPF</span>
                <span>Alternance</span>
              </div>
            </div>
            <div class="hero-panel highlight">
              <div class="panel-title">Accompagnement personnalise</div>
              <p>Un tuteur dedie vous accompagne tout au long de votre parcours de formation.</p>
              <div class="progress">
                <div class="progress-bar" />
              </div>
            </div>
          </div>
        </div>
      </section>

      <section class="certs" id="alternance">
        <div class="certs-inner">
          <div class="cert">Certifie Qualiopi</div>
          <div class="cert">Titres RNCP</div>
          <div class="cert">Eligible CPF</div>
        </div>
      </section>

      <section class="section" id="apropos">
        <div class="section-header">
          <h2>Pourquoi nous choisir</h2>
        </div>
        <div class="feature-grid">
          <div class="feature-card">
            <h3>Diplomes reconnus</h3>
            <p>
              Titres professionnels RNCP reconnus par l'Etat et valorises par les entreprises.
            </p>
          </div>
          <div class="feature-card">
            <h3>Accompagnement personnalise</h3>
            <p>Un tuteur dedie vous accompagne tout au long de votre parcours de formation.</p>
          </div>
          <div class="feature-card">
            <h3>Rythme adapte</h3>
            <p>Alternance 4 jours entreprise / 1 jour formation, ou formation continue flexible.</p>
          </div>
        </div>
      </section>

      <section class="section alt" id="formations">
        <div class="section-header">
          <h2>Nos formations</h2>
          <p class="section-subtitle">
            Des programmes certifiants pour les metiers les plus recherches
          </p>
        </div>
        <div class="course-grid">
          <article v-for="course in courses" :key="course.title" class="course-card">
            <div class="course-tags">
              <span v-if="course.alternance">Alternance</span>
              <span>CPF</span>
            </div>
            <h3>{{ course.title }}</h3>
            <p>{{ course.description }}</p>
            <div class="course-meta">{{ course.duration }}</div>
          </article>
        </div>
        <div class="section-actions">
          <a class="btn ghost" href="#contact">Voir toutes les formations</a>
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
            <h2>Pret a vous lancer ?</h2>
            <p class="lead">Contactez-nous pour en savoir plus sur nos formations.</p>
          </div>
          <div class="cta-actions">
            <a class="btn primary" href="mailto:hello@move37.fr">Nous contacter</a>
            <a class="btn ghost" href="#formations">Voir les formations</a>
          </div>
        </div>
      </section>
    </main>

    <footer class="footer">
      <div class="footer-grid">
        <div>
          <div class="brand">Move37 Campus</div>
          <p>Centre de formation certifie Qualiopi</p>
        </div>
        <div>
          <div class="footer-title">Formations</div>
          <div class="footer-links">
            <a href="#formations">Toutes les formations</a>
            <a href="#alternance">Alternance</a>
          </div>
        </div>
        <div>
          <div class="footer-title">Entreprises</div>
          <div class="footer-links">
            <a href="#entreprises">Recruter un alternant</a>
            <a href="#contact">Nous contacter</a>
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
          <a href="#">Mentions legales</a>
          <a href="#">Confidentialite</a>
        </div>
      </div>
    </footer>
  </div>
</template>
