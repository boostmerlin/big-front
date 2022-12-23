<script setup lang="ts">
import Icon from '@iconify/svelte';
import { hasAnyPrizes, loadPrizes, takePrize } from "common/model";
import type { Prize } from "common/model";
import { generateCandidates } from "common/model/util";
import Animate from "../components/Animate.svelte";
import Row from "../components/Row.svelte";
import RedPacket from "../components/RedPacket.svelte";
import { navigateTo } from 'svelte-router-spa';

const ANI_TIME = 0.3;

let selected: Prize = null;
let prizes = loadPrizes();
let round = 1;
let candidates: Prize[][] = [];

function backToConfig() {
  navigateTo('/config');
}

$: {
  if (!hasAnyPrizes()) {
    backToConfig();
  }
  candidates = generateCandidates(prizes);
}

const onTakePrize = () => {
  const p = selected;
  if (!p) return;
  takePrize(p);
  selected = null;
  round++;
  console.log(`You got ${p.name}`);
  prizes = loadPrizes();
};

$: active = selected === null;

const onOpen = (prize: Prize) => {
  selected = prize;
};
</script>

<div>
  <!-- svelte-ignore a11y-click-events-have-key-events -->
  <div on:click={backToConfig} class="back">
    <Icon icon="mdi:arrow-back-circle" style="font-size:4vh;color:coral"/>
  </div>
  <!-- svelte-ignore a11y-click-events-have-key-events -->
  <div class="container" on:click={onTakePrize}>
    {#each candidates as c, i}
    <Row>
      {#each c as r, j}
      <Animate
        active={active}
        delay={(i * 3 + j) * ANI_TIME * 0.8}
      >
        <RedPacket
          active={active}
          round={round}
          prize={r}
          onOpen={onOpen}
        />
      </Animate>
      {/each}
    </Row>
    {/each}
  </div>
</div>

<style>
@import "common/css/PrizeTake.css";
</style>
