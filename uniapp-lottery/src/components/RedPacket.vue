<script setup lang="ts">
//compose api in setup(props, context)
import type { Prize } from "common/model";
import { OPEN } from "common/model/Strings";
import { ref, watch } from "vue";

interface IProps {
  active: boolean;
  round: number;
  onOpen: (prize: Prize) => void;
  prize: Prize;
}
//compiler macro.
const props = defineProps<IProps>();

const open = ref(false);

const handleOpen = () => {
  console.log("open prize", props.prize.name);
  window.playAppear();
  open.value = true;
  props.onOpen(props.prize);
};

watch(
  () => props.round,
  () => {
    open.value = false;
  }
);
</script>

<template>
  <view :class="['redpacket', { shake: open }]">
    <view class="prize">
      <text>{{ prize.name }}</text>
    </view>
    <view :class="['redpacket-lower', { open }]" />
    <view :class="['redpacket-upper', { open }]">
      <view
        :class="['redpacket-button', { fade: open }]"
        @click.stop="active ? handleOpen() : undefined"
      >
        {{ OPEN }}
      </view>
    </view>
  </view>
</template>

<style>
@import "common/css/RedPacket.css";
</style>
