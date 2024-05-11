// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pacer/helper/adapters.dart';
import 'package:pacer/helper/classes.dart';
import 'package:pacer/widgets/compass.dart';
import 'package:pacer/screens.dart/widgetscreen.dart';
import 'package:pacer/widgets/speedometer.dart';
import 'package:pacer/widgets/weather_widget.dart';

Future<void> main() async {
  //
  //necessary binding
  TestWidgetsFlutterBinding.ensureInitialized();
  final temp = await Directory.systemTemp.createTemp();
  Hive.init(temp.path);
  Hive.registerAdapter(PlaceAdapter());
  Hive.registerAdapter(WalkAdapter());
  Hive.registerAdapter(DayDataAdapter());
  Hive.registerAdapter(HourAdapter());
  Hive.registerAdapter(DailyAdapter());
  Hive.registerAdapter(WeeklyAdapter());
  Hive.registerAdapter(MonthlyAdapter());
  Hive.registerAdapter(YearlyAdapter());
  Hive.registerAdapter(PolylineAdapter());
  await Hive.openBox<Walk>('walks');
  await Hive.openBox<DayData>('weekData');
  await Hive.openBox<Place>("places");
  await Hive.openBox<Walk>('backup');
  await Hive.openBox<Yearly>('yearlyList');
  await Hive.openBox<Monthly>('monthlyList');
  await Hive.openBox<Weekly>('weeklyList');
  await Hive.openBox<Daily>('dailyList');
  await Hive.openBox<Polyline>('polylines');

  //test for widget screen
  testWidgets('Widget Screen Test', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: WidgetsScreen(currentLanguage: 'en')));
    expect(find.byType(WeatherWidget), findsOneWidget);
    expect(find.byType(CompassWidget), findsOneWidget);
    expect(find.byType(SpeedometerWidget), findsOneWidget);
  });
  print('--> System Test Passed Successfully!');
}
