<style>
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen",
    "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: #e7d8d8;
}
</style>
<template>
  <!--no scoped on style -->
  <div>
    <router-view></router-view>
  </div>
</template>

<script lang="ts">
  import "common/js/Sound"
  window.playBg();
</script>
