<template>
  <div :style="animateStyle">
    <slot></slot>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import "animate.css";
export const ANI_TIME = 0.3;
const animation = {
  animation: `${ANI_TIME * 2}s backInDown ease backwards`,
  animationDelay: 0,
};
//use defineComponent to write a component easily
export default defineComponent({
  props: {
    delay: Number,
    active: Boolean,
  },
  computed: {
    animateStyle() {
      return this.active
        ? { ...animation, animationDelay: `${this.delay}s` }
        : undefined;
    },
  },
});
</script>
