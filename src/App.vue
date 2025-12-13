<template>
  <div class="app">
    <header class="topbar">
      <div class="brand" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" class="logo" aria-hidden="true">
          <path
            d="M12 2L2 7v6c0 5 7 9 10 9s10-4 10-9V7L12 2z"
            fill="currentColor"
          />
        </svg>

        <div>
          <h1>MoodDiary</h1>
          <small>дневник настроения</small>
        </div>
      </div>

      <nav>
        <router-link to="/">Главная</router-link>
        <router-link to="/diary">Дневник</router-link>
        <router-link to="/new" class="accent">Новая запись</router-link>
        <router-link to="/stats">Статистика</router-link>
      </nav>
    </header>

    <main class="container">
      <router-view />
    </main>
  </div>
</template>

<script>
export default {
  name: "App",
};
</script>