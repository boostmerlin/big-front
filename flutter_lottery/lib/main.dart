import 'package:flutter/material.dart';
import 'package:flutter_lottery/audio/sound.dart';
import 'package:flutter_lottery/views/prize_config.dart';
import 'package:flutter_lottery/views/prize_take.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initAudio();
  }

  void initAudio() async {
    await Sound.init();
    //bg play got a error on web(Must interactive first.)
    await Sound.play('bg.mp3', loop: true);
  }

   @override
  void dispose() {
    Sound.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lottery',
      color: const Color(0xFFFF9000),
      initialRoute: '/config',
      routes: {
        '/config': (BuildContext context) =>
            const Material(child: PrizeConfig()),
        '/take': (BuildContext context) => const Material(child: PrizeTake()),
      },
    );
  }
}
