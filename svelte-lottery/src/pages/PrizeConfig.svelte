<script lang="ts">
import { PRIZE_CONFIG, NO_PRIZE, PRIZE_NAME, PRIZE_COUNT } from "common/model/Strings";
import { loadPrizes, totalPrizes, hasAnyPrizes } from "common/model";
import type { Prize } from 'common/model';
import * as util from "common/model/util";
import Row from "../components/Row.svelte";
import { navigateTo } from 'svelte-router-spa'
import Icon from '@iconify/svelte';

let prizes = loadPrizes();
let totalSize = totalPrizes();

const updateState = (newPrizes: Prize[]) => {
  prizes = [...newPrizes];
  totalSize = totalPrizes();
};

function handleStart() {
  if (hasAnyPrizes()) {
    window.playAppear();
    navigateTo("/take");
  } else {
    window.playError();
    window.alert(NO_PRIZE);
  }
}
</script>

<div class="LotteryView">
  <h1 class="title">{ PRIZE_CONFIG }</h1>
  <table aria-hidden="true">
    <thead>
      <tr>
        <th scope="col">{PRIZE_NAME}</th>
        <th scope="cols">{PRIZE_COUNT}</th>
      </tr>
    </thead>
    <tbody>
      {#each prizes as {name, count}, i }
      <tr>
        <td>
          <input
            name="name"
            placeholder="配置名称"
            value={name}
            on:change={util.handleNameChange(i, updateState)}
          />
        </td>
        <td>
          <input
            name="count"
            type="number"
            max="{99}"
            min="{0}"
            value={count}
            on:change={util.handleCountChange(i, updateState)}
          />
        </td>
        <td>
          <div
            class="button"
            on:keydown={()=>{}}
            on:click={util.handleRemove(i, updateState)}
          >
            <Icon icon="ic:baseline-remove-circle-outline" style="color:red" />
          </div>
        </td>
      </tr>
      {/each}
    </tbody>
    <tfoot>
      <tr>
        <th scope="row">共计：</th>
        <td>{ totalSize }</td>
      </tr>
    </tfoot>
  </table>
  <Row>
    <!-- svelte-ignore a11y-click-events-have-key-events -->
    <div class="button" color="red" on:click={util.handleAdd(updateState)}>
      <Icon icon="material-symbols:add-circle-outline" style="color:#c3a26e" />
    </div>
    <!-- svelte-ignore a11y-click-events-have-key-events -->
    <div class="button" on:click={handleStart}>
      <Icon icon="material-symbols:play-circle-outline" style="color:green"/>
    </div>
  </Row>
</div>
<footer>
  Powered by ml@Svelte
</footer>

<style scoped>
@import "common/css/PrizeConfig.css";
</style>
