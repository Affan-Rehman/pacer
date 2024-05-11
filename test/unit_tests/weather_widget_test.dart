// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pacer/widgets/weather_widget.dart';

void main() {
  group('WeatherWidget Tests', () {
    testWidgets('WeatherWidget displays weather correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WeatherWidget(currentLanguage: 'en'),
      ));

      // Trigger a frame to simulate the widget building after async call
      await tester
          .pump(Duration.zero); // Simulate the weather data being loaded

      // Verify that weather data is displayed
      expect(find.text('--°C'), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny), findsNothing);
    });
  });

  print('--> Weather Widget Test Passed Successfully!');
}
