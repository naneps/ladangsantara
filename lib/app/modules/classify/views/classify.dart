import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'plant_recogniser.dart';

class Classify extends StatelessWidget {
  const Classify ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      title: 'Plant Recognizer',
      theme: ThemeData.light(),
      home: const PlantRecogniser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
