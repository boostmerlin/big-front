<script lang="ts">
import type { Prize } from "common/model";
import { OPEN } from "common/model/Strings";

export let prize: Prize;
export let round: number;
export let onOpen: (prize: Prize) => void;
export let active: boolean;

let open = false;

const handleOpen = () => {
  console.log("open prize", prize.name);
  open = true;
  onOpen(prize);
};

let lastRound = round;

$: if(lastRound !== round) {
    console.log("round change: %d", round)
    lastRound = round;
    open = false;
}

</script>

<div class="redpacket" class:shake={open}>
  <div class="prize">
    <span>{ prize.name }</span>
  </div>
  <div class='redpacket-lower' class:open />
  <div class='redpacket-upper' class:open>
    <!-- svelte-ignore a11y-click-events-have-key-events -->
    <div
      class='redpacket-button' class:fade={open}
      on:click|stopPropagation={active ? handleOpen : undefined}
    >
      { OPEN }
    </div>
  </div>
</div>

<style>
@import "common/css/RedPacket.css";
</style>
