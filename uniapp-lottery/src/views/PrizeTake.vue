<script setup lang="ts">
//会被自动注册
import { hasAnyPrizes, loadPrizes, Prize, takePrize } from "common/model";
import { computed, defineComponent, h, ref, unref, watchEffect } from "vue";
import { generateCandidates } from "common/model/util";
import Animate, { ANI_TIME } from "../components/Animate.vue";
import Row from "../components/Row.vue";
import RedPacket from "../components/RedPacket.vue";

const selected = ref<Prize | null>(null);
const prizes = ref(loadPrizes());
const round = ref(1);
let candidates: Prize[][] = [];
watchEffect(() => {
  console.log("effect prizes", unref(prizes));
  if (!hasAnyPrizes()) {
    return uni.navigateBack();
  }
  candidates = generateCandidates(prizes.value);
});

const onTakePrize = () => {
  const p = unref(selected);
  if (!p) {
    window.playError();
    return;
  }
  window.playAppear();
  takePrize(p);
  selected.value = null;
  round.value++;
  console.log(`You got ${p.name}`);
};

const active = computed(() => unref(selected) === null);

function onClick() {
  window.playAppear();
  uni.navigateBack();
}

const onOpen = (prize: Prize) => {
  selected.value = prize;
  window.playHooray();
};
</script>

<template>
  <uni-icons class="back" type="left" color="#c3a26e" size="4vh" @click="onClick"/>
  <view>
    <!--className do works!!-->
    <view className="container" @click="onTakePrize">
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
    </view>
  </view>
</template>

<style>
@import "common/css/PrizeTake.css";
</style>
