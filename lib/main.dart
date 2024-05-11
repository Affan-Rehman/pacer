// ignore_for_file: unused_field, prefer_const_constructors

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pacer/helper/adapters.dart';
import 'package:pacer/helper/classes.dart';
import 'package:pacer/screens.dart/homescreen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get the application documents directory for storing Hive data
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
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

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4500), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _showSplash ? SplashScreen() : HomeScreen(),
    );
  }
}
