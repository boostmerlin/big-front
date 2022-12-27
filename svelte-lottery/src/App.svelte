<script lang="ts">
  import { Router } from 'svelte-router-spa';
  import routes from './router';
  import "common/js/Sound"
  window.playBg();
</script>

<main>
  <Router {routes} />
</main>
