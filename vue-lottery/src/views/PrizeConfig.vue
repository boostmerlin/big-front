<script setup lang="ts">
import { PRIZE_CONFIG, NO_PRIZE, PRIZE_NAME, PRIZE_COUNT } from "common/model/Strings";
import { loadPrizes, totalPrizes, hasAnyPrizes, Prize } from "common/model";
import {
  BIconDashCircle,
  BIconPlayCircle,
  BIconPlusCircle,
} from "bootstrap-icons-vue";
import * as util from "common/model/util";
import Row from "../components/Row.vue";
import { useRouter } from "vue-router";

import { ref } from "vue";

const prizes = ref(loadPrizes());
const router = useRouter();

const updateState = (newPrizes: Prize[]) => {
  prizes.value = [...newPrizes];
};

function handleStart() {
  if (hasAnyPrizes()) {
    window.playAppear();
    router.push("/take");
  } else {
    window.playError();
    window.alert(NO_PRIZE);
  }
}
</script>

<template>
  <div class="LotteryView">
    <h1 class="title">{{ PRIZE_CONFIG }}</h1>
    <table aria-hidden="true">
      <thead>
        <tr>
          <th scope="col">{{ PRIZE_NAME }}</th>
          <th scope="cols">{{ PRIZE_COUNT }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="({ name, count }, i) in prizes" :key="i">
          <td>
            <input
              name="name"
              placeholder="配置名称"
              :value="name"
              v-on:change="util.handleNameChange(i, updateState)($event)"
            />
          </td>
          <td>
            <input
              name="count"
              type="number"
              max="{{99}}"
              min="{{0}}"
              :value="count"
              @change="util.handleCountChange(i, updateState)($event)"
            />
          </td>
          <td>
            <div
              class="button"
              @click="util.handleRemove(i, updateState)()"
            >
              <BIconDashCircle color="red"/>
            </div>
          </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <th scope="row">共计：</th>
          <td>{{ totalPrizes() }}</td>
        </tr>
      </tfoot>
    </table>
    <Row>
      <div class="button" @click="util.handleAdd(updateState)()">
        <BIconPlusCircle color="#c3a26e" />
      </div>
      <div class="button" @click="handleStart">
        <BIconPlayCircle color="green" />
      </div>
    </Row>
  </div>
  <footer>
    Powered by ml@Vue
  </footer>
</template>

<style scoped>
@import "common/css/PrizeConfig.css";
</style>
