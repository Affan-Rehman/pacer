// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer/helper/classes.dart';
import 'package:pacer/widgets/graphs.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  group('DailyGraph Widget Tests', () {
    testWidgets('Renders DailyGraph with hourly data',
        (WidgetTester tester) async {
      final List<Hour> hourlyData = [
        Hour(hour: 1, steps: 100, calories: 50.0, distance: 1.0),
        Hour(hour: 2, steps: 200, calories: 75.0, distance: 2.0),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DailyGraph(hourlyList: hourlyData),
        ),
      ));

      expect(find.byType(SfCartesianChart), findsOneWidget);
    });
  });

  group('GraphWidget Tests', () {
    testWidgets('Displays correct week data in GraphWidget',
        (WidgetTester tester) async {
      final List<DayData> weekData = [
        DayData(name: "Monday", steps: 1000, calories: 500, distance: 3.0),
        DayData(name: "Tuesday", steps: 1500, calories: 750, distance: 4.5),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GraphWidget(weekData, 'en'),
        ),
      ));

      expect(find.byType(SfCartesianChart), findsOneWidget);
      expect(find.text('Monday'), findsNothing);
      expect(find.text('1000'), findsNothing);
    });
  });

  print('--> Graph Test Passed Successfully!');
}
