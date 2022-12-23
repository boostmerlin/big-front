

<script lang="ts">
import "animate.css";

const ANI_TIME = 0.3;

export let delay = 0;
export let active = false;

console.log("animate: " + active);

$: animateStyle = `--time:${ANI_TIME*2}s;--delay:${delay}s`;
</script>

<!--不支持对象形式，写到css中，通过变量形式-->
<div id="div1" style="{animateStyle}" class={active ? "animation-x" : undefined}>
  <slot></slot>
</div>

<style>
  .animation-x {
    animation: var(--time, 1s) backInDown ease backwards;
    animation-delay: var(--delay, 0s);
  }
</style>