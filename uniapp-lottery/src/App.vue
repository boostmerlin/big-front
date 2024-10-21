<style>
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
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

<script setup lang="ts">
  import { onLaunch, onShow, onHide } from '@dcloudio/uni-app';
  import 'common/js/Sound';
  window.playBg();
  onLaunch(() => {
    console.log('App Launch');
  });
  onShow(() => {
    console.log('App Show');
  });
  onHide(() => {
    console.log('App Hide');
  });
</script>
