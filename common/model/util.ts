import { addPrize, loadPrizes, Prize, removePrize, updatePrize } from "./index";
import { shuffle, flatten, chunk } from "lodash";

export const take = <T>(array: Array<T>, n: number) => {
  const length = array.length;

  if (length === n) {
    return array;
  }
  if (length > n) {
    array.splice(0, length - n);
    return array;
  }

  for (let i = length; i < n; ++i) {
    const dup = Math.floor(Math.random() * length);
    array.push(array[dup]);
  }
  return array;
};


const numberOfCandidates = 6;
const numberOfCandidatesInAChunk = numberOfCandidates / 2;

export const generateCandidates = (prizes: Prize[]): Prize[][] =>
  chunk(
    take(
      shuffle(
        flatten(
          prizes.map((v) => {
            return new Array(v.count).fill({ name: v.name, count: 1 });
          })
        )
      ),
      numberOfCandidates
    ),
    numberOfCandidatesInAChunk
  );

type onUpdateState = (newState: Prize[]) => void;

//注意，这里不需要绑定this对象
export function handleNameChange(index: number, stateUpdate: onUpdateState) {
  return (event: any) => {
    const name = event.target.value;
    console.log(index);
    const newState = updatePrize(index, { name });
    stateUpdate(newState);
  };
}

export function handleCountChange(index: number, stateUpdate: onUpdateState) {
  return (event: any) => {
    const value = event.target.value;
    const newState = updatePrize(index, { count: parseInt(value) });
    stateUpdate(newState);
  };
}

export function handleRemove(index: number, stateUpdate: onUpdateState) {
  return () => {
    const prizes = loadPrizes();
    if (window.confirm(`确定要删除奖品：${prizes[index].name}`)) {
      const newState = removePrize(index);
      stateUpdate(newState);
    }
  };
}

export const handleAdd = (stateUpdate: onUpdateState) => () =>
  stateUpdate(addPrize());
