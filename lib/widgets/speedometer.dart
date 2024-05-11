// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:alxgration_speedometer/speedometer.dart';
import 'package:flutter/material.dart';
import 'package:pacer/constants.dart';

class SpeedometerWidget extends StatelessWidget {
  final double speed;

  SpeedometerWidget({Key? key, required this.speed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int speedValue = speed.toInt();

    return Speedometer(
      minValue: 0,
      maxValue: 200,
      currentValue: speedValue,
      pointerColor: Colors.white,
      barColor: AppColors.colorPrimaryDark,
      displayText: 'km/h',
    );
  }
}
