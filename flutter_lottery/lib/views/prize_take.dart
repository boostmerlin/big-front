import 'package:flutter/material.dart';
import 'package:flutter_lottery/components/delay_slide_down.dart';
import 'package:flutter_lottery/components/red_packet.dart';
import 'package:flutter_lottery/model/index.dart';
import 'package:flutter_lottery/model/utils.dart';

import '../audio/sound.dart';

class BackButton extends StatefulWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  State<BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButton> {
  double iconSize = 1;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          iconSize = 1.1;
        });
      },
      onExit: ((event) {
        setState(() {
          iconSize = 1.0;
        });
      }),
      child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 200),
          tween: Tween<double>(begin: 1, end: iconSize),
          builder: (BuildContext context, double value, _) {
            return Transform.scale(
              scale: value,
              child: IconButton(
                alignment: Alignment.center,
                icon: const Icon(
                    color: Colors.lightBlue, Icons.arrow_circle_left),
                onPressed: () {
                  Sound.play('appear.mp3');
                  Navigator.pushNamed(context, '/config');
                },
              ),
            );
          }),
    );
  }
}

class PrizeTake extends StatefulWidget {
  const PrizeTake({Key? key}) : super(key: key);

  @override
  State<PrizeTake> createState() => _PrizeTakeState();
}

class _PrizeTakeState extends State<PrizeTake> {
  late List<List<Prize>> candidates;

  Prize? selected;
  int round = 0;

  @override
  void initState() {
    super.initState();
    _initCandidates();
  }

  void _initCandidates() {
    candidates = generateCandidates(loadPrizes());
  }

  void _onTakePrize() {
    if (selected == null) {
      print("error state, no prize selected");
      Sound.play('error.mp3');
      return;
    }
    Sound.play('appear.mp3');
    takePrize(selected!);
    round++;
    setState(() {
      _initCandidates();
      selected = null;
    });
  }

  void _onOpen(Prize prize) {
    print('choose prize $prize');
    Sound.play('hooray.mp3');
    setState(() {
      selected = prize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTakePrize,
      child: Container(
        color: const Color(0xffe7d8d8),
        child: Stack(
          children: [
            const Padding(padding: EdgeInsets.all(18), child: BackButton()),
            Center(
              child: SizedBox(
                  width: 520,
                  height: 420,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: candidates
                        .asMap()
                        .map((i, e) => MapEntry(
                            i,
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: e
                                    .asMap()
                                    .map(((j, value) => MapEntry(
                                        j,
                                        DelaySlideDown(
                                          key: Key((j+round*e.length).toString()),
                                          delayMills: ((i * 3 + j) *
                                              kAniTime *
                                              0.8) as int,
                                          child: RedPacket(
                                            prize: value,
                                            active: selected == null,
                                            onOpen: _onOpen,
                                          ),
                                        ))))
                                    .values
                                    .toList(growable: false))))
                        .values
                        .toList(growable: false),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
