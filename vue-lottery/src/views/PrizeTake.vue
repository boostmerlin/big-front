<script setup lang="ts">
//会被自动注册
import { BIconArrowLeftCircle } from "bootstrap-icons-vue";
import { hasAnyPrizes, loadPrizes, Prize, takePrize } from "common/model";
import { computed, defineComponent, h, ref, unref, watchEffect } from "vue";
import { generateCandidates } from "common/model/util";
import Animate, { ANI_TIME } from "../components/Animate.vue";
import Row from "../components/Row.vue";
import RedPacket from "../components/RedPacket.vue";
import { useRouter } from "vue-router";

const Back = defineComponent({
  // components: {
  //     BIconArrowLeftCircle,
  // },
  methods: {
    onClick() {
      this.$router.back();
    },
  },
  render() {
    return h(
      "div",
      {
        class: "back",
        onClick: this.onClick,
      },
      h(BIconArrowLeftCircle, { color: "#c3a26e", "font-size": "4vh" })
    );
  },
});

const selected = ref<Prize | null>(null);
const prizes = ref(loadPrizes());
const round = ref(1);
let candidates: Prize[][] = [];
const router = useRouter();
watchEffect(() => {
  console.log("effect prizes", unref(prizes));
  if (!hasAnyPrizes()) {
    return router.back();
  }
  candidates = generateCandidates(prizes.value);
});

const onTakePrize = () => {
  const p = unref(selected);
  if (!p) return;
  takePrize(p);
  selected.value = null;
  round.value++;
  console.log(`You got ${p.name}`);
};

const active = computed(() => unref(selected) === null);

const onOpen = (prize: Prize) => {
  selected.value = prize;
};
</script>

<template>
  <div>
    <Back />
    <div className="container" @click="onTakePrize">
      <Row v-for="(c, i) of candidates" :key="i">
        <Animate
          v-for="(r, j) in c"
          :key="j"
          :active="active"
          :delay="(i * 3 + j) * ANI_TIME * 0.8"
        >
          <RedPacket
            :active="active"
            :round="round"
            :prize="r"
            :onOpen="onOpen"
          />
        </Animate>
      </Row>
    </div>
  </div>
</template>

<style>
@import "common/css/PrizeTake.css";
</style>
