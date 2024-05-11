// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alxgration_speedometer/speedometer.dart';
import 'package:pacer/constants.dart';
import 'package:pacer/widgets/speedometer.dart';

void main() {
  group('SpeedometerWidget Tests', () {
    testWidgets('Displays correct speed and configurations',
        (WidgetTester tester) async {
      const double testSpeed = 120.5;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SpeedometerWidget(speed: testSpeed),
        ),
      ));

      expect(find.byType(Speedometer), findsOneWidget);

      final Speedometer speedometerWidget =
          tester.widget<Speedometer>(find.byType(Speedometer));
      expect(speedometerWidget.currentValue, testSpeed.toInt());
      expect(speedometerWidget.minValue, 0);
      expect(speedometerWidget.maxValue, 200);
      expect(speedometerWidget.pointerColor, Colors.white);
      expect(speedometerWidget.barColor, AppColors.colorPrimaryDark);
      expect(speedometerWidget.displayText, 'km/h');
    });
  });

  print('--> Speedometer Test Passed Successfully!');
}
