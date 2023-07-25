// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:hive/hive.dart';

import 'classes.dart';
import 'package:intl/intl.dart';

List<Yearly> yearlyList = [];
List<Monthly> monthlyList = [];
List<Weekly> weeklyList = [];
List<Daily> dailyList = [];
List<Hour> hourList = [];

class StepCalculator {
  static final StepCalculator _instance = StepCalculator._internal();

  factory StepCalculator() {
    return _instance;
  }

  StepCalculator._internal();

  int currentSteps = 0;
  Timer? hourlyTimer;
  Timer? dailyTimer;
  Timer? weeklyTimer;
  Timer? monthlyTimer;
  Timer? yearlyTimer;

  bool isCalculating = false;

  void start() {
    if (!isCalculating) {
      isCalculating = true;

      // Initialize objects and data for passed intervals
      initializePassedIntervals();

      // Start calculating and updating objects
      calculateAndUpdateObjects();

      hourlyTimer = Timer.periodic(Duration(hours: 1), (Timer timer) {
        updateHourly(currentSteps);
      });

      dailyTimer = Timer.periodic(Duration(days: 1), (Timer timer) {
        updateDaily();
      });

      weeklyTimer = Timer.periodic(Duration(days: 7), (Timer timer) {
        updateWeekly();
      });

      monthlyTimer = Timer.periodic(Duration(days: 30), (Timer timer) {
        updateMonthly();
      });

      yearlyTimer = Timer.periodic(Duration(days: 365), (Timer timer) {
        updateYearly();
      });
    }
  }

  void initializePassedIntervals() {
    DateTime now = DateTime.now();

    // Initialize hourly data for passed hours in the current day
    for (int i = 0; i < now.hour; i++) {
      Hour hourly = Hour(
        hour: i,
        steps: 0,
        calories: 0,
        distance: 0,
      );
      hourList.add(hourly);
    }

    // Initialize daily data for passed days in the current week
    DateTime currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
    for (DateTime date = currentWeekStart;
        date.isBefore(now);
        date = date.add(Duration(days: 1))) {
      List<Hour> dailyHourList = List.from(hourList);
      Daily daily = Daily(
        hourList: dailyHourList,
        day: date.toString(),
      );
      dailyList.add(daily);
      hourList.clear();
    }

    // Initialize weekly data for passed weeks in the current month
    DateTime currentMonthStart = DateTime(now.year, now.month, 1);
    for (DateTime date = currentMonthStart;
        date.isBefore(now);
        date = date.add(Duration(days: 7))) {
      DateTime weekStart = date.subtract(Duration(days: date.weekday - 1));
      DateTime weekEnd = weekStart.add(Duration(days: 6));
      List<Daily> weekDailyList = dailyList
          .where((daily) =>
              DateTime.parse(daily.day).isAfter(weekStart) &&
              DateTime.parse(daily.day).isBefore(weekEnd))
          .toList();
      Weekly weekly = Weekly(
        name:
            '${DateFormat('MMMM d').format(weekStart)} - ${DateFormat('MMMM d').format(weekEnd)}',
        startDate: weekStart,
        endDate: weekEnd,
        dailyList: weekDailyList,
        steps: calculateWeeklySteps(weekDailyList),
        calories: calculateWeeklyCalories(weekDailyList),
        distance: calculateWeeklyDistance(weekDailyList),
      );
      weeklyList.add(weekly);
      dailyList.clear();
    }

    // Initialize monthly data for passed months in the current year
    for (int month = 1; month < now.month; month++) {
      DateTime monthStart = DateTime(now.year, month, 1);
      DateTime monthEnd =
          monthStart.add(Duration(days: daysInMonth(month, now.year) - 1));
      List<Weekly> monthWeeklyList = weeklyList
          .where((weekly) =>
              weekly.startDate.isAfter(monthStart) &&
              weekly.endDate.isBefore(monthEnd))
          .toList();
      Monthly monthly = Monthly(
        startDate: monthStart,
        endDate: monthEnd,
        weeklyList: monthWeeklyList,
        steps: calculateMonthlySteps(monthWeeklyList),
        calories: calculateMonthlyCalories(monthWeeklyList),
        distance: calculateMonthlyDistance(monthWeeklyList),
        name: DateFormat('MMMM').format(monthStart),
      );
      monthlyList.add(monthly);
      weeklyList.clear();
    }

    // Initialize yearly data for passed years before the current year
    for (int year = now.year - 1; year >= 1900; year--) {
      DateTime yearStart = DateTime(year, 1, 1);
      DateTime yearEnd = yearStart.add(Duration(days: daysInYear(year)));
      List<Monthly> yearMonthlyList = monthlyList
          .where((monthly) =>
              monthly.startDate.isAfter(yearStart) &&
              monthly.endDate.isBefore(yearEnd))
          .toList();
      Yearly yearly = Yearly(
        year: yearStart,
        monthlyList: yearMonthlyList,
        steps: calculateYearlySteps(yearMonthlyList),
        calories: calculateYearlyCalories(yearMonthlyList),
        distance: calculateYearlyDistance(yearMonthlyList),
      );
      yearlyList.add(yearly);
      monthlyList.clear();
    }

    // Save the initial data to Hive collections
    Hive.box<Yearly>('yearlyList').putAll(yearlyList.asMap());
    Hive.box<Monthly>('monthlyList').putAll(monthlyList.asMap());
    Hive.box<Weekly>('weeklyList').putAll(weeklyList.asMap());
    Hive.box<Daily>('dailyList').putAll(dailyList.asMap());
  }

  void calculateAndUpdateObjects() {
    Pedometer.stepCountStream.listen((StepCount event) {
      currentSteps = event.steps; // Update currentSteps

      updateHourly(currentSteps);
    });
  }

  void updateHourly(int steps) {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    Hour hourly = Hour(
      hour: currentHour,
      steps: steps,
      calories: calculateCalories(steps),
      distance: calculateDistance(steps),
    );
    hourList.add(hourly);
  }

  void updateDaily() async {
    DateTime now = DateTime.now();
    if (now.hour == 0 && now.minute == 0 && now.second == 0) {
      DateTime currentDateTime = DateTime(now.year, now.month, now.day);
      List<Hour> dailyHourList = List.from(hourList);
      Daily daily =
          Daily(hourList: dailyHourList, day: currentDateTime.toString());
      dailyList.add(daily);
      hourList.clear();

      updateWeekly();
      updateMonthly();
      updateYearly();

      // Open the polylines box
      final polylinesBox =
          await Hive.openBox<Map<PolylineId, Polyline>>("polylines");

      // Clear all data from the box
      await polylinesBox.clear();

      final backUpbox = await Hive.openBox<Map<PolylineId, Polyline>>("backup");

      // Clear all data from the box
      await backUpbox.clear();

      // Save the lists in Hive collections
      Hive.box<Yearly>('yearlyList').putAll(yearlyList.asMap());
      Hive.box<Monthly>('monthlyList').putAll(monthlyList.asMap());
      Hive.box<Weekly>('weeklyList').putAll(weeklyList.asMap());
      Hive.box<Daily>('dailyList').putAll(dailyList.asMap());
    }
  }

  void updateWeekly() {
    DateTime now = DateTime.now();
    if (now.weekday == DateTime.sunday &&
        now.hour == 0 &&
        now.minute == 0 &&
        now.second == 0) {
      DateTime startDate = now.subtract(Duration(days: now.weekday - 1));
      DateTime endDate = startDate.add(Duration(days: 6));
      List<Daily> weekDailyList = dailyList
          .where((daily) =>
              DateTime.parse(daily.day).isAfter(startDate) &&
              DateTime.parse(daily.day).isBefore(endDate))
          .toList();
      String weekName =
          '${DateFormat('MMMM d').format(startDate)} - ${DateFormat('MMMM d').format(endDate)}';
      Weekly weekly = Weekly(
          name: weekName,
          startDate: startDate,
          endDate: endDate,
          dailyList: weekDailyList,
          steps: calculateWeeklySteps(weekDailyList),
          calories: calculateWeeklyCalories(weekDailyList),
          distance: calculateWeeklyDistance(weekDailyList));
      weeklyList.add(weekly);
      dailyList.clear();
    }
  }

  void updateMonthly() {
    DateTime now = DateTime.now();
    if (now.day == 1 && now.hour == 0 && now.minute == 0 && now.second == 0) {
      DateTime startDate = DateTime(now.year, now.month, 1);
      DateTime endDate = startDate.add(
          Duration(days: daysInMonth(startDate.month, startDate.year) - 1));
      List<Weekly> monthWeeklyList = weeklyList
          .where((weekly) =>
              weekly.startDate.isAfter(startDate) &&
              weekly.endDate.isBefore(endDate))
          .toList();
      Monthly monthly = Monthly(
          startDate: startDate,
          endDate: endDate,
          weeklyList: monthWeeklyList,
          steps: calculateMonthlySteps(monthWeeklyList),
          calories: calculateMonthlyCalories(monthWeeklyList),
          distance: calculateMonthlyDistance(monthWeeklyList),
          name: DateFormat('MMMM').format(now));
      monthlyList.add(monthly);
      weeklyList.clear();
    }
  }

  void updateYearly() {
    DateTime now = DateTime.now();
    if (now.month == 1 &&
        now.day == 1 &&
        now.hour == 0 &&
        now.minute == 0 &&
        now.second == 0) {
      DateTime startDate = DateTime(now.year, 1, 1);
      DateTime endDate =
          startDate.add(Duration(days: daysInYear(startDate.year)));
      List<Monthly> yearMonthlyList = monthlyList
          .where((monthly) =>
              monthly.startDate.isAfter(startDate) &&
              monthly.endDate.isBefore(endDate))
          .toList();
      Yearly yearly = Yearly(
          year: startDate,
          monthlyList: yearMonthlyList,
          steps: calculateYearlySteps(yearMonthlyList),
          calories: calculateYearlyCalories(yearMonthlyList),
          distance: calculateYearlyDistance(yearMonthlyList));
      yearlyList.add(yearly);
      monthlyList.clear();
    }
  }

  double calculateDistance(int steps) {
    double distance = (steps * 0.762) / 1000;
    distance = double.parse(distance.toStringAsFixed(1));
    return distance;
  }

  double calculateCalories(int steps) {
    double calories = steps * 0.04;
    calories = double.parse(calories.toStringAsFixed(1));
    return calories;
  }

  int daysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  int daysInYear(int year) {
    DateTime startDate = DateTime(year, 1, 1);
    DateTime endDate = DateTime(year + 1, 1, 1);
    return endDate.difference(startDate).inDays;
  }

  int calculateWeeklySteps(List<Daily> weekDailyList) {
    return weekDailyList.fold(0, (sum, daily) => sum + daily.steps);
  }

  double calculateWeeklyCalories(List<Daily> weekDailyList) {
    return weekDailyList.fold(0.0, (sum, daily) => sum + daily.calories);
  }

  double calculateWeeklyDistance(List<Daily> weekDailyList) {
    return weekDailyList.fold(0.0, (sum, daily) => sum + daily.distance);
  }

  int calculateMonthlySteps(List<Weekly> monthWeeklyList) {
    return monthWeeklyList.fold(0, (sum, weekly) => sum + weekly.steps);
  }

  double calculateMonthlyCalories(List<Weekly> monthWeeklyList) {
    return monthWeeklyList.fold(0.0, (sum, weekly) => sum + weekly.calories);
  }

  double calculateMonthlyDistance(List<Weekly> monthWeeklyList) {
    return monthWeeklyList.fold(0.0, (sum, weekly) => sum + weekly.distance);
  }

  int calculateYearlySteps(List<Monthly> yearMonthlyList) {
    return yearMonthlyList.fold(0, (sum, monthly) => sum + monthly.steps);
  }

  double calculateYearlyCalories(List<Monthly> yearMonthlyList) {
    return yearMonthlyList.fold(0.0, (sum, monthly) => sum + monthly.calories);
  }

  double calculateYearlyDistance(List<Monthly> yearMonthlyList) {
    return yearMonthlyList.fold(0.0, (sum, monthly) => sum + monthly.distance);
  }
}
