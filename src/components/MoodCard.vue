<template>
  <div class="mood-card card">
    <div class="mood-emoji">{{ emoji }}</div>
    <div class="mood-meta">
      <slot />
    </div>
  </div>
</template>

<script>
export default {
  props: { emoji: { type: String, default: '😊' } }
}
</script>
