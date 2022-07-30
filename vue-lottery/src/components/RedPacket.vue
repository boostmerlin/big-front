<script setup lang="ts">
//compose api in setup(props, context)
import { Prize } from "common/model";
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
  <div :class="['redpacket', { shake: open }]">
    <div class="prize">
      <span>{{ prize.name }}</span>
    </div>
    <div :class="['redpacket-lower', { open }]" />
    <div :class="['redpacket-upper', { open }]">
      <div
        :class="['redpacket-button', { fade: open }]"
        @click.stop="active ? handleOpen() : undefined"
      >
        {{ OPEN }}
      </div>
    </div>
  </div>
</template>

<style>
@import "common/css/RedPacket.css";
</style>
