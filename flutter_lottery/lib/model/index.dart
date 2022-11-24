import 'dart:convert';
import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

final _localStorage = window.localStorage;

const kStorage = "prizes";

class Prize {
  String? name;
  int? count;
  Prize({this.name, this.count});
  @override
  String toString() {
    return "$name = $count";
  }
  Map toJson() {
    Map map = {};
    map["name"] = name;
    map["count"] = count;
    return map;
  }

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      name: json["name"],
      count: json["count"],
    );
  }
}

final kDefault = <Prize>[
  Prize(name: "文具一套", count: 10),
  Prize(name: "书籍一本", count: 10),
  Prize(name: "玩游戏一小时", count: 3),
  Prize(name: "刷抖音一小时", count: 3),
  Prize(name: "写代码一小时", count: 3),
];

final defaultPrizes = [...kDefault];

List<Prize> loadPrizes() {
  final store = _localStorage[kStorage];
  if (store == null) {
    return defaultPrizes;
  }
  final List<dynamic> dataList = json.decode(store);
  return dataList
      .map((e) => Prize(
            name: e["name"],
            count: e["count"],
          ))
      .toList();
}

void savePrizes(List<Prize> prizes) =>
    _localStorage.update(kStorage, (_) => jsonEncode(prizes),
        ifAbsent: () => jsonEncode(prizes));

List<Prize> takePrize(Prize prize) {
  final prizes = loadPrizes();
  try {
    final found = prizes.firstWhere((element) => element.name == prize.name);
    final n = found.count!;
    if (n > 0) {
      found.count = n - 1;
      savePrizes(prizes);
    }
  } on StateError {
    log("没有找到奖品");
  }

  return prizes;
}

addPrize() {
  final prizes = loadPrizes();
  prizes.add(Prize(name: "", count: 0));
  savePrizes(prizes);
  return prizes;
}

updatePrize(int index, Prize prize) {
  final prizes = loadPrizes();
  if (index < 0 || index >= prizes.length) {
    return prizes;
  }
  prize.count ??= prizes[index].count;
  prize.name ??= prizes[index].name;
  prizes[index] = prize;
  savePrizes(prizes);
  return prizes;
}

removePrize(int index) {
  final prizes = loadPrizes();
  if (index < 0 || index >= prizes.length) {
    return prizes;
  }
  prizes.removeAt(index);
  savePrizes(prizes);
  return prizes;
}

hasAnyPrizes() {
  final prizes = loadPrizes();
  if (prizes.isEmpty) {
    return false;
  }
  return prizes.any((p) => p.count! > 0);
}

totalPrizes() {
  final prizes = loadPrizes();
  if (prizes.isEmpty) {
    return 0;
  }
  return prizes.fold<int>(0, (s, v) => s + v.count!);
}
