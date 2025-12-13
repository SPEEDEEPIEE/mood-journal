<template>
  <div class="page">
    <section class="card">
      <h2>Статистика</h2>
      <p class="lead">Распредление настроений за весь период.</p>

      <div style="display:flex;gap:12px;align-items:center;margin-top:18px">
        <div style="flex:1">
          <div v-if="total===0" style="color:var(--muted)">Нет данных для анализа.</div>
          <div v-else>
            <div style="display:flex;gap:8px;align-items:center">
              <strong>Всего записей:</strong> <span style="margin-left:8px">{{ total }}</span>
            </div>

            <div style="margin-top:12px">
              <div style="display:flex;gap:8px;align-items:center">
                <div style="width:12px;height:12px;background:#7ee7b3;border-radius:4px"></div> <span>Позитивные: {{ counts.happy }}</span>
              </div>
              <div style="display:flex;gap:8px;align-items:center;margin-top:6px">
                <div style="width:12px;height:12px;background:#cbd5e1;border-radius:4px"></div> <span>Нейтральные: {{ counts.neutral }}</span>
              </div>
              <div style="display:flex;gap:8px;align-items:center;margin-top:6px">
                <div style="width:12px;height:12px;background:#ffb4b4;border-radius:4px"></div> <span>Отрицательные (грусть/злость): {{ counts.sad + counts.angry }}</span>
              </div>
            </div>
          </div>
        </div>

        <aside style="width:200px;text-align:center">
          <div style="font-size:36px">{{ percentPositive }}%</div>
          <div style="color:var(--muted)">позитивных</div>
        </aside>
      </div>
    </section>

    <aside class="card">
      <h3>Интерпретация</h3>
      <p class="lead">Если доля позитивных настроений меньше 30% — подумай о том, чтобы поговорить с близкими или специалистом.</p>
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
    const counts = computed(()=>{
      const c = { happy:0, neutral:0, sad:0, angry:0 }
      entries.value.forEach(e=>{
        if(e.mood==='happy') c.happy++
        else if(e.mood==='neutral') c.neutral++
        else if(e.mood==='sad') c.sad++
        else if(e.mood==='angry') c.angry++
      })
      return c
    })
    const total = computed(()=> entries.value.length)
    const percentPositive = computed(()=> total.value ? Math.round((counts.value.happy/total.value)*100) : 0)
    return { counts, total, percentPositive }
  }
}
</script>
