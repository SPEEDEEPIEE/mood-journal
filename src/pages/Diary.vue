<template>
  <div class="page">
    <section class="card">
      <h2>Дневник</h2>
      <p class="lead">Список твоих записей (сохраняется в localStorage).</p>

      <div style="margin:12px 0;display:flex;gap:8px;flex-wrap:wrap">
        <button class="tag" @click="filterTag('')">Все</button>
        <button class="tag" v-for="t in uniqueTags" :key="t" @click="filterTag(t)">{{ t }}</button>
      </div>

      <div v-if="entries.length === 0" style="color:var(--muted);padding:24px;background:var(--glass);border-radius:12px">Записей пока нет — добавь первую!</div>

      <div class="diary-list" v-else>
        <div v-for="entry in filtered" :key="entry.id" class="mood-card">
          <div class="mood-emoji" :title="entry.mood">{{ entry.emoji }}</div>
          <div class="mood-meta">
            <h3>{{ entry.title || formatDate(entry.date) }}</h3>
            <small>{{ entry.note }}</small>
            <div class="mood-tags">
              <span class="tag" v-for="t in entry.tags" :key="t">{{ t }}</span>
            </div>
          </div>
          <div style="display:flex;flex-direction:column;gap:8px">
            <button class="ghost btn" @click="edit(entry)">Изм.</button>
            <button class="btn" @click="del(entry.id)" style="background:transparent;border:1px solid rgba(255,80,90,0.14);color:#ffb4b4">Удал.</button>
          </div>
        </div>
      </div>
    </section>

    <aside class="card">
      <h3>Быстрые действия</h3>
      <p style="color:var(--muted)">Добавь новую запись или перейди в статистику, чтобы посмотреть распределение.</p>
      <div style="margin-top:12px;display:flex;gap:10px">
        <router-link to="/new" class="accent">Новая запись</router-link>
        <router-link to="/stats" class="ghost btn">Статистика</router-link>
      </div>
    </aside>
  </div>
</template>

<script>
import { ref, computed } from 'vue'
const STORAGE_KEY = 'mood_diary_entries_v1'
function load(){ try{ return JSON.parse(localStorage.getItem(STORAGE_KEY)||'[]') }catch(e){return []} }
export default {
  setup(){
    const entries = ref(load())

    function save(){ localStorage.setItem(STORAGE_KEY, JSON.stringify(entries.value)) }

    function del(id){
      if(!confirm('Удалить запись?')) return
      entries.value = entries.value.filter(e => e.id !== id); save()
    }
    function edit(entry){
      // quick navigation to edit via new with query param
      const url = { path: '/new', query: { edit: entry.id } }
      window.history.pushState({}, '', '#/new?edit=' + entry.id) // so router sees it
      location.reload()
    }

    const uniqueTags = computed(()=>{
      const set = new Set()
      entries.value.forEach(e=> (e.tags||[]).forEach(t=>set.add(t)))
      return Array.from(set)
    })

    const filter = ref('')
    function filterTag(t){ filter.value = t }

    const filtered = computed(()=>{
      if(!filter.value) return entries.value.slice().reverse()
      return entries.value.filter(e=> (e.tags||[]).includes(filter.value)).reverse()
    })

    function formatDate(d){ return new Date(d).toLocaleString() }

    return { entries, del, edit, formatDate, uniqueTags, filtered, filterTag }
  }
}
</script>
