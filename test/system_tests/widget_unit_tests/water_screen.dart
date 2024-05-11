// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pacer/helper/adapters.dart';
import 'package:pacer/helper/classes.dart';
import 'package:pacer/screens.dart/wateractivity.dart';
import 'package:pacer/widgets/drawable_glass.dart';

Future<void> main() async {
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

  testWidgets('WaterActivity Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: WaterActivity(),
    ));

    expect(find.text('Water'), findsOneWidget);
    expect(find.text('Water Drank: 0 glasses'), findsOneWidget);
    expect(find.byType(DraggableGlass), findsOneWidget);
    expect(find.byType(DragTarget), findsOneWidget);
  });

  print('--> System Test Passed Successfully!');
}
