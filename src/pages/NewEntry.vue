<template>
  <div class="page">
    <section class="card">
      <h2>{{ mode === 'edit' ? 'Редактирование' : 'Новая запись' }}</h2>
      <p class="lead">Отметь настроение, добавь заголовок, заметку и теги через запятую.</p>

      <form @submit.prevent="submit">
        <div style="display:flex;gap:10px;margin-bottom:12px;align-items:center">
          <select v-model="mood">
            <option value="happy">😊 Счастлив/а</option>
            <option value="neutral">😐 Нейтрально</option>
            <option value="sad">😔 Грусть</option>
            <option value="angry">😠 Злость</option>
          </select>

          <input type="text" placeholder="Короткий заголовок (необязательно)" v-model="title" />
        </div>

        <textarea v-model="note" placeholder="Опиши, что произошло..." />

        <div style="margin-top:8px">
          <input type="text" v-model="tagsInput" placeholder="Теги через запятую (например: работа,семья)" />
        </div>

        <div class="controls">
          <button type="button" class="ghost btn" @click="reset">Сброс</button>
          <button type="submit" class="primary btn">{{ mode === 'edit' ? 'Сохранить' : 'Добавить' }}</button>
        </div>
      </form>
    </section>

    <aside class="card">
      <h3>Эмоция</h3>
      <div style="font-size:46px;text-align:center;margin-top:8px">{{ emoji }}</div>
      <p style="color:var(--muted);margin-top:12px">Эмоции помогают отслеживать паттерны и реакции. Пиши честно.</p>
    </aside>
  </div>
</template>

<script>
import { ref, computed, onMounted } from 'vue'
const STORAGE_KEY = 'mood_diary_entries_v1'
function load(){ try{ return JSON.parse(localStorage.getItem(STORAGE_KEY)||'[]') }catch(e){return []} }
function saveAll(arr){ localStorage.setItem(STORAGE_KEY, JSON.stringify(arr)) }
export default {
  setup(){
    const all = load()
    const title = ref('')
    const note = ref('')
    const tagsInput = ref('')
    const mood = ref('happy')
    const mode = ref('new')
    const editId = ref(null)

    const emoji = computed(()=>{
      return mood.value === 'happy' ? '😊' : mood.value === 'neutral' ? '😐' : mood.value === 'sad' ? '😔' : '😠'
    })

    onMounted(()=>{
      // check for edit query param
      const params = new URLSearchParams(window.location.search || window.location.hash.split('?')[1] || '')
      if(params.get('edit')){
        editId.value = params.get('edit')
        const e = all.find(x => String(x.id) === String(editId.value))
        if(e){ mode.value='edit'; title.value = e.title; note.value = e.note; mood.value = e.mood; tagsInput.value = (e.tags||[]).join(',') }
      }
    })

    function submit(){
      const tags = tagsInput.value.split(',').map(s=>s.trim()).filter(Boolean)
      if(mode.value==='edit' && editId.value){
        const idx = all.findIndex(x=>String(x.id)===String(editId.value))
        if(idx>-1){
          all[idx] = { ...all[idx], title: title.value, note: note.value, tags, mood: mood.value }
          saveAll(all); alert('Сохранено'); window.location.href = '/diary'
          return
        }
      }
      const entry = { id: Date.now(), title: title.value, note: note.value, tags, mood: mood.value, date: new Date().toISOString(), emoji: emoji.value }
      all.push(entry); saveAll(all)
      title.value=''; note.value=''; tagsInput.value=''; mood.value='happy'
      alert('Запись добавлена'); window.location.href = '/diary'
    }

    function reset(){ title.value=''; note.value=''; tagsInput.value=''; mood.value='happy' }

    return { title, note, tagsInput, mood, submit, reset, emoji, mode }
  }
}
</script>
