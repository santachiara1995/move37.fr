<script setup>
import { onMounted, ref } from 'vue'

const apiBase = import.meta.env.VITE_API_URL || 'http://localhost:3000'

const notes = ref([])
const title = ref('')
const body = ref('')
const loading = ref(false)
const error = ref('')

const loadNotes = async () => {
  loading.value = true
  error.value = ''

  try {
    const response = await fetch(`${apiBase}/api/notes`)
    const data = await response.json()
    notes.value = data.items ?? []
  } catch (err) {
    error.value = 'Unable to reach the API.'
  } finally {
    loading.value = false
  }
}

const createNote = async () => {
  if (!title.value.trim()) {
    error.value = 'Title is required.'
    return
  }

  error.value = ''

  try {
    const response = await fetch(`${apiBase}/api/notes`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title: title.value, body: body.value })
    })

    if (!response.ok) {
      const data = await response.json()
      error.value = data?.error || 'Unable to create note.'
      return
    }

    title.value = ''
    body.value = ''
    await loadNotes()
  } catch (err) {
    error.value = 'Unable to create note.'
  }
}

const removeNote = async (id) => {
  error.value = ''

  try {
    await fetch(`${apiBase}/api/notes/${id}`, { method: 'DELETE' })
    await loadNotes()
  } catch (err) {
    error.value = 'Unable to delete note.'
  }
}

onMounted(loadNotes)
</script>

<template>
  <div class="app">
    <header class="hero">
      <p class="eyebrow">VPS Template</p>
      <h1>Vue + Vite + Bun + Elysia + SQLite</h1>
      <p class="lead">
        A clean starting point with a tiny notes API, SQLite storage, and a front-end
        that calls it.
      </p>
      <div class="pill">API: {{ apiBase }}</div>
    </header>

    <section class="grid">
      <div class="card">
        <h2>Create a note</h2>
        <p class="muted">Add a quick note to confirm the stack is wired up.</p>
        <form class="stack" @submit.prevent="createNote">
          <label class="field">
            <span>Title</span>
            <input v-model="title" type="text" placeholder="Launch checklist" />
          </label>
          <label class="field">
            <span>Body</span>
            <textarea v-model="body" rows="4" placeholder="Remember to open port 3000." />
          </label>
          <button class="primary" type="submit">Save note</button>
        </form>
        <p v-if="error" class="error">{{ error }}</p>
      </div>

      <div class="card">
        <div class="card-header">
          <h2>Saved notes</h2>
          <button class="ghost" type="button" @click="loadNotes" :disabled="loading">
            {{ loading ? 'Refreshing...' : 'Refresh' }}
          </button>
        </div>
        <div v-if="notes.length === 0" class="empty">
          <p>No notes yet olala putain. Add one to verify SQLite haha GOAT.</p>
        </div>
        <ul v-else class="notes">
          <li v-for="note in notes" :key="note.id">
            <div>
              <h3>{{ note.title }}</h3>
              <p>{{ note.body || 'No body content.' }}</p>
              <span class="meta">{{ new Date(note.createdAt).toLocaleString() }}</span>
            </div>
            <button class="danger" type="button" @click="removeNote(note.id)">Delete</button>
          </li>
        </ul>
      </div>
    </section>
  </div>
</template>
