import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'freshness_recognize.dart';

class Classify extends StatelessWidget {
  const Classify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      title: 'Freshness Detection',
      theme: ThemeData.light(),
      home: const FrehsnessRecognize(),
      debugShowCheckedModeBanner: false,
    );
  }
}