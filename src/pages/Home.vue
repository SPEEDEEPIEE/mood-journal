<template>
  <div class="page">
    <section class="card">
      <h2>Привет!</h2>
      <p class="lead">Добро пожаловать в MoodDiary — место, где можно быстро отмечать настроение, наблюдать динамику и сохранять небольшие заметки о дне.</p>

      <div style="display:flex;gap:12px;margin-top:18px">
        <router-link to="/new" class="accent">Добавить запись</router-link>
        <router-link to="/diary" class="ghost btn">Открыть дневник</router-link>
      </div>

      <hr style="margin:18px 0;border:none;border-top:1px solid rgba(255,255,255,0.02)">

      <h3>Как это работает</h3>
      <ol style="color:var(--muted);margin-left:18px">
        <li>Добавляешь запись с эмоцией, описанием и тегами.</li>
        <li>Смотришь журнал записей и фильтруешь по тегам.</li>
        <li>Анализируешь статистику — процент положительных/нейтральных/отрицательных настроений.</li>
      </ol>
    </section>

    <aside class="card">
      <h3>Совет дня</h3>
      <p class="lead">Если чувствуешь упадок — запиши две вещи, за которые благодарен. Часто это меняет перспективу.</p>
    </aside>
  </div>
</template>
