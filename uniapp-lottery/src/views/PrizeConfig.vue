<script setup lang="ts">
import { PRIZE_CONFIG, NO_PRIZE, PRIZE_NAME, PRIZE_COUNT } from "common/model/Strings";
import { loadPrizes, totalPrizes, hasAnyPrizes, Prize } from "common/model";

import * as util from "common/model/util";
import Row from "../components/Row.vue";

import { ref } from "vue";

type updatePrizeFunc = (index: number, f: util.onUpdateState) => (e: any)=>void

const prizes = ref(loadPrizes());

const updateState = (newPrizes: Prize[]) => {
  prizes.value = [...newPrizes];
};

function handleStart() {
  if (hasAnyPrizes()) {
    window.playAppear();
    uni.navigateTo({
		url: 'PrizeTake'
    })
  } else {
    window.playError();
    window.alert(NO_PRIZE);
  }
}

function onInputChangeWrap(index: number, f: updatePrizeFunc) {
  return (event: any) => {
	  console.log(event)
    const value = event.detail.value;
    const e = {target: {value}}
	f(index, updateState)(e)
  };
}

</script>

<template>
  <view class="LotteryView">
    <h1 class="title">{{ PRIZE_CONFIG }}</h1>
    <table aria-hidden="true">
      <thead>
        <tr>
          <th scope="col">{{ PRIZE_NAME }}</th>
          <th scope="cols">{{ PRIZE_COUNT }}</th>
        </tr>
      </thead>
      <tbody>
        <tr class v-for="({ name, count }, i) in prizes" :key="i">
          <td>
            <input
              name="name"
              placeholder="配置名称"
              :value="name"
              v-on:input="onInputChangeWrap(i, util.handleNameChange)($event)"
            />
          </td>
          <td>
            <input
			  class="input"
              name="count"
              type="number"
			  maxlength="3"
              :value="count"
              @input="onInputChangeWrap(i, util.handleCountChange)($event)"
            />
          </td>
          <td>
            <view
              class="button"
              @click="util.handleRemove(i, updateState)()"
            >
			        <uni-icons type="close" color="red" size="40"></uni-icons>
            </view>
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
      <view class="button" @click="util.handleAdd(updateState)()">
		<uni-icons type="plus" color="#c3a26e" size="5vh"></uni-icons>
      </view>
      <view class="button" @click="handleStart">
        <uni-icons type="circle" color="green" size="5vh"></uni-icons>
        <uni-icons style="position: absolute; left:2vh;" type="right" color="green" size="3vh"></uni-icons>
      </view>
    </Row>
  </view>
  <footer>
    Powered by ml@uni-app
  </footer>
</template>

<style scoped>
@import "common/css/PrizeConfig.css";
.input {
	width: 4rem;
	text-align: end;
}
</style>
