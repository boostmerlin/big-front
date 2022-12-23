<script lang="ts">
  import { Router } from 'svelte-router-spa';
  import routes from './router';
</script>

<main>
  <Router {routes} />
</main>
