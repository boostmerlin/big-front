import 'package:flutter/material.dart';
import 'package:flutter_lottery/views/prize_config.dart';
import 'package:flutter_lottery/views/prize_take.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  // // many widget like textfield need Material.
  // @override
  // Widget build(BuildContext context) {
  //   return WidgetsApp(
  //       title: 'Flutter Lottery',
  //       color: const Color(0xFFFF9000),
  //       initialRoute: '/config',
  //       routes: {
  //         '/': (BuildContext context) => const PrizeConfig(),
  //         '/config': (BuildContext context) => const PrizeConfig(),
  //         '/take': (BuildContext context) => const PrizeTake(),
  //       },
  //       pageRouteBuilder: <Widget>(settings, builder) {
  //         return PageRouteBuilder(
  //           settings: settings,
  //           pageBuilder: (context, animation, secondaryAnimation) {
  //             final w = builder(context);
  //             return Localizations(
  //               locale: const Locale('en', 'zh'),
  //               delegates: const <LocalizationsDelegate<dynamic>>[
  //                 DefaultWidgetsLocalizations.delegate,
  //                 DefaultMaterialLocalizations.delegate,
  //               ],
  //               child: MediaQuery(
  //                 data: const MediaQueryData(),
  //                 child: Directionality(
  //                   textDirection: TextDirection.ltr,
  //                   child: Material(
  //                     child: w,
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       });
}
