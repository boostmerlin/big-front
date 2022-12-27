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