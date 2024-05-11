// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pacer/helper/adapters.dart';
import 'package:pacer/helper/classes.dart';
import 'package:pacer/screens.dart/goalscreen.dart';
import 'package:pacer/screens.dart/historyscreen.dart';
import 'package:pacer/screens.dart/homescreen.dart';

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
  // initializeService(true);

  //test for Splash Screen, Log in Screen
  testWidgets('Splash Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    await tester.pump(const Duration(milliseconds: 4500));
    expect(find.text("Pacer"), findsOneWidget);
  });

  //test for home screen
  testWidgets('Home Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    expect(find.text("Pacer"), findsOneWidget);
  });

  //test for history screen
  testWidgets('history Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HistoryScreen('en')));
    expect(find.text("Daily"), findsOneWidget);
  });

  //test for goal screen
  testWidgets('Goal Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GoalScreen('en')));
    expect(find.text("Goal"), findsOneWidget);
  });

  print('--> System Test Passed Successfully!');
}
