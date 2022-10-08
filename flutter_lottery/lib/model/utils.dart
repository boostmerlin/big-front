import 'dart:math';

import 'index.dart';
import 'package:dartx/dartx.dart';

List<Prize> take(List<Prize> array, int n) {
  final length = array.length;

  if (length == n) {
    return array;
  }
  if (length > n) {
    array.removeRange(n, length);
    return array;
  }
  var r = Random();
  for (var i = length; i < n; ++i) {
    final dup = r.nextInt(length);
    array.add(array[dup]);
  }
  return array;
}


const numberOfCandidates = 6;
const numberOfCandidatesInAChunk = 3;

/// row 2 x col 3, count is 1.
List<List<Prize>> generateCandidates(List<Prize> prizes) {
  final candidates = prizes
  .map((p) => List<Prize>.filled(p.count!, Prize(count: 1, name: p.name)))
  .flatten()
  .shuffled();
  final takes = take(candidates, numberOfCandidates);
  return takes.chunked(numberOfCandidatesInAChunk).toList();
}

//注意，这里不需要绑定this对象
// handleNameChange(index: number, stateUpdate: onUpdateState) {
//   return (event: any) => {
//     const name = event.target.value;
//     console.log(index);
//     const newState = updatePrize(index, { name });
//     stateUpdate(newState);
//   };
// }

// export function handleCountChange(index: number, stateUpdate: onUpdateState) {
//   return (event: any) => {
//     const value = event.target.value;
//     const newState = updatePrize(index, { count: parseInt(value) });
//     stateUpdate(newState);
//   };
// }

// export function handleRemove(index: number, stateUpdate: onUpdateState) {
//   return () => {
//     const prizes = loadPrizes();
//     if (
//       prizes[index].count === 0 ||
//       window.confirm(`确定要删除奖品：${prizes[index].name}`)
//     ) {
//       const newState = removePrize(index);
//       stateUpdate(newState);
//     }
//   };
// }

// export const handleAdd = (stateUpdate: onUpdateState) => () =>
//   stateUpdate(addPrize());
