import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lottery/components/alert.dart';

import '../model/index.dart';
import '../model/strings.dart';

const kTitleSize = TextStyle(fontSize: 50, color: Color(0xFFFE5E4F));
const kHeaderStyle = TextStyle(
    fontSize: 35, fontStyle: FontStyle.italic, color: Color(0xffc3a26e));
const kItemSize = 60.0;
const kItemStyle = TextStyle(fontSize: 25, color: Color(0xffc3a26e));

class PrizeConfig extends StatefulWidget {
  const PrizeConfig({Key? key}) : super(key: key);

  @override
  State<PrizeConfig> createState() => _PrizeConfigState();
}

class _PrizeConfigState extends State<PrizeConfig> {
  List<Prize> _prizes = loadPrizes();

  List<TableRow> _buildPrizeRows() {
    int index = 0;
    return _prizes.map((Prize prize) {
      final bg = index++ % 2 == 0 ? Colors.transparent : Colors.white60;
      return TableRow(
        children: <Widget>[
          Container(
            height: kItemSize,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 8),
            child: TextField(
                controller: TextEditingController(text: prize.name),
                style: kItemStyle,
                decoration: const InputDecoration(
                  hintText: "配置名称",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Color(0xffc3a26e), fontStyle: FontStyle.italic),
                ),
                onChanged: (text) {
                  prize.name = text;
                  savePrizes(_prizes);
                }),
          ),
          Container(
            color: bg,
            height: kItemSize,
            alignment: Alignment.center,
            margin: const EdgeInsetsDirectional.all(1),
            child: TextField(
                textAlign: TextAlign.right,
                controller: TextEditingController(text: prize.count.toString()),
                style: kItemStyle,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numb
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  prize.count = int.tryParse(text) ?? 0;
                  savePrizes(_prizes);
                  setState(() {
                  });
                }),
          ),
          Container(
            height: kItemSize,
            width: kItemSize,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: IconButton(
                color: Colors.transparent,
                onPressed: () async {
                  bool remove = true;
                  if (prize.count! > 0) {
                    var ok = await alertDialog(context);
                    remove = ok == 'ok';
                  }
                  if (remove) {
                    setState(() {
                      _prizes.remove(prize);
                      savePrizes(_prizes);
                    });
                  }
                },
                icon: const Icon(
                  CupertinoIcons.delete_solid,
                  color: Color(0xffa3a26e),
                )),
          )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe7d8d8),
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(prizeConfig, style: kTitleSize),
          ),
          SizedBox(
            width: 480,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(1.0),
                2: IntrinsicColumnWidth(),
              },
              children: [
                const TableRow(
                  children: [
                    Center(
                      child: Text(
                        prizeName,
                        style: kHeaderStyle,
                      ),
                    ),
                    Center(
                      child: Text(
                        prizeCount,
                        style: kHeaderStyle,
                      ),
                    ),
                    Text(''),
                  ],
                ),
                ..._buildPrizeRows(),
                TableRow(
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('总计：', style: kHeaderStyle,),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(totalPrizes().toString(), style: kHeaderStyle,),
                    ),
                    const Text(''),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  color: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      _prizes = addPrize();
                    });
                  },
                  icon: const Icon(
                    CupertinoIcons.add_circled,
                    color: Colors.orange,
                    size: 40,
                  )),
              const Padding(padding: EdgeInsets.only(left: 10)),
              IconButton(
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/take');
                  },
                  icon: const Icon(CupertinoIcons.play_circle,
                      color: Colors.green, size: 40)),
            ],
          ),
        ],
      ),
    );
  }
}
