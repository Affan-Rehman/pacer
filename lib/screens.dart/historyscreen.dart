// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pacer/helper/stepcalculator.dart';
import '../constants.dart';
import '../helper/classes.dart';
import 'package:intl/intl.dart';
import '../widgets/graphs.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen(this.currentLanguage);

  String currentLanguage = "en";

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

int steps = 0;
double calories = 0;
double distance = 0;
double avgCal = 0;

class _HistoryScreenState extends State<HistoryScreen> {
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;
  int selectedButtonIndex = 0;
  int iconIndex = 0;
  String date = "today";
  int yearIndex = 0;
  int monthIndex = 0;
  int weekIndex = 0;
  int dayIndex = 0;

  List<Yearly> dummyYearly = List<Yearly>.generate(2, (index) {
    // Generate a list of monthly data for each year
    List<Monthly> yearMonths = List<Monthly>.generate(3, (monthIndex) {
      // Generate a list of weekly data for each month
      List<Weekly> monthWeeks = List<Weekly>.generate(4, (weekIndex) {
        // Generate a list of daily data for each week
        List<Daily> weekDays = List<Daily>.generate(7, (dayIndex) {
          // Generate a list of hourly data for each day
          List<Hour> hourList = List<Hour>.generate(24, (hourIndex) {
            // Replace the dummy values with your desired values for steps, calories, and distance
            int steps = (monthIndex + weekIndex + dayIndex + hourIndex) * 100;
            double calories =
                (monthIndex + weekIndex + dayIndex + hourIndex) * 10.0;
            double distance =
                (monthIndex + weekIndex + dayIndex + hourIndex) * 0.5;

            return Hour(
              hour: hourIndex,
              steps: steps,
              calories: calories,
              distance: distance,
            );
          });

          // Create a Daily object for each day of the week
          String dayName = [
            'Mon',
            'Tue',
            'Wed',
            'Thu',
            'Fri',
            'Sat',
            'Sun',
          ][dayIndex];

          return Daily(
            hourList: hourList,
            day: dayName,
          );
        });

        // Create a Weekly object for each week
        DateTime startDate =
            DateTime.now(); // Replace with your actual start date
        DateTime endDate =
            startDate.add(Duration(days: 6)); // Add 6 days instead of 7
        String weekName =
            '${DateFormat('MMMM d').format(startDate)} - ${DateFormat('MMMM d').format(endDate)}';

        // Calculate the total steƒps, calories, distance, and average calories for the weekly data
        int steps = weekDays.fold(0, (sum, daily) => sum + daily.steps);
        double calories =
            weekDays.fold(0.0, (sum, daily) => sum + daily.calories);
        double distance =
            weekDays.fold(0.0, (sum, daily) => sum + daily.distance);

        return Weekly(
          name: weekName,
          startDate: startDate,
          endDate: endDate,
          dailyList: weekDays,
          steps: steps,
          calories: calories,
          distance: distance,
        );
      });

      // Create a Monthly object for each month
      String monthName = DateFormat('MMMM').format(DateTime.now());

      // Calculate the total steps, calories, distance, and average calories for the monthly data
      int steps = monthWeeks.fold(0, (sum, weekly) => sum + weekly.steps);
      double calories =
          monthWeeks.fold(0.0, (sum, weekly) => sum + weekly.calories);
      double distance =
          monthWeeks.fold(0.0, (sum, weekly) => sum + weekly.distance);

      return Monthly(
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          weeklyList: monthWeeks,
          steps: steps,
          calories: calories,
          distance: distance,
          name: monthName);
    });

    // Calculate the total steps, calories, distance, and average calories for the yearly data
    int steps = yearMonths.fold(0, (sum, monthly) => sum + monthly.steps);
    double calories =
        yearMonths.fold(0.0, (sum, monthly) => sum + monthly.calories);
    double distance =
        yearMonths.fold(0.0, (sum, monthly) => sum + monthly.distance);

    return Yearly(
      year: DateTime.now(),
      monthlyList: yearMonths,
      steps: steps,
      calories: calories,
      distance: distance,
    );
  });

  bool showDaily = true;
  bool showWeekly = false;
  bool showMonthly = false;
  bool showYearly = false;

  int index = 0;
  List<Daily> currentDaily = [];
  List<Weekly> currentWeekly = [];
  List<Monthly> currentMonthly = [];
  List<Yearly> currentYearly = [];

  @override
  void initState() {
    super.initState();

    if (yearlyList.isNotEmpty &&
        yearIndex < yearlyList.length &&
        yearlyList[yearIndex].monthlyList.isNotEmpty &&
        monthIndex < yearlyList[yearIndex].monthlyList.length &&
        yearlyList[yearIndex].monthlyList[monthIndex].weeklyList.isNotEmpty &&
        weekIndex <
            yearlyList[yearIndex].monthlyList[monthIndex].weeklyList.length) {
      currentDaily = yearlyList[yearIndex]
          .monthlyList[monthIndex]
          .weeklyList[weekIndex]
          .dailyList;
    } else {
      currentDaily = []; // Set empty list if any of the nested lists are empty
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showDaily) {
      steps = currentDaily.fold(0, (sum, daily) => sum + daily.steps);
      calories = currentDaily.fold(0.0, (sum, daily) => sum + daily.calories);
      distance = currentDaily.fold(0.0, (sum, daily) => sum + daily.distance);
    } else if (showWeekly) {
      steps = currentWeekly.fold(0, (sum, weekly) => sum + weekly.steps);
      calories =
          currentWeekly.fold(0.0, (sum, weekly) => sum + weekly.calories);
      distance =
          currentWeekly.fold(0.0, (sum, weekly) => sum + weekly.distance);
    } else if (showMonthly) {
      steps = currentMonthly.fold(0, (sum, monthly) => sum + monthly.steps);
      calories =
          currentMonthly.fold(0.0, (sum, monthly) => sum + monthly.calories);
      distance =
          currentMonthly.fold(0.0, (sum, monthly) => sum + monthly.distance);
    } else if (showYearly) {
      steps = currentYearly.fold(0, (sum, yearly) => sum + yearly.steps);
      calories =
          currentYearly.fold(0.0, (sum, yearly) => sum + yearly.calories);
      distance =
          currentYearly.fold(0.0, (sum, yearly) => sum + yearly.distance);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorPrimaryDark.withOpacity(0.3),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 0;
                            showDaily = true;
                            showWeekly = false;
                            showMonthly = false;
                            showYearly = false;
                            currentDaily = yearlyList[yearIndex]
                                .monthlyList[monthIndex]
                                .weeklyList[weekIndex]
                                .dailyList;
                            index = 0;
                            date = currentDaily[index].day.toString();
                          });
                        },
                        child: Text(
                          translatedStrings[widget.currentLanguage]!["daily"] ??
                              AppStrings.translations["en"]!["daily"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedButtonIndex == 0
                                ? AppColors.colorAccent
                                : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorPrimaryDark.withOpacity(0.3),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 1;
                            showDaily = false;
                            showWeekly = true;
                            showMonthly = false;
                            showYearly = false;
                            currentWeekly = yearlyList[yearIndex]
                                .monthlyList[monthIndex]
                                .weeklyList;
                            index = 0;
                            date = currentWeekly[index].name;
                          });
                        },
                        child: Text(
                          translatedStrings[widget.currentLanguage]![
                                  "weekly"] ??
                              AppStrings.translations["en"]!["weekly"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedButtonIndex == 1
                                ? AppColors.colorAccent
                                : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorPrimaryDark.withOpacity(0.3),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 2;
                            showDaily = false;
                            showWeekly = false;
                            showMonthly = true;
                            showYearly = false;
                            currentMonthly = yearlyList[yearIndex].monthlyList;
                            index = 0;
                            date = currentMonthly[index].name;
                          });
                        },
                        child: Text(
                          translatedStrings[widget.currentLanguage]![
                                  "monthly"] ??
                              AppStrings.translations["en"]!["monthly"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedButtonIndex == 2
                                ? AppColors.colorAccent
                                : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorPrimaryDark.withOpacity(0.3),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 3;
                            showDaily = false;
                            showWeekly = false;
                            showMonthly = false;
                            showYearly = true;
                            currentYearly = yearlyList;
                            index = 0;
                            date = currentYearly[index].year.year.toString();
                          });
                        },
                        child: Text(
                          translatedStrings[widget.currentLanguage]![
                                  "yearly"] ??
                              AppStrings.translations["en"]!["yearly"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedButtonIndex == 3
                                ? AppColors.colorAccent
                                : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.colorPrimaryDark.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.colorAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          if (showDaily) {
                            index =
                                (index - 1).clamp(0, currentDaily.length - 1);
                            date = currentDaily[index].day.toString();
                          } else if (showWeekly) {
                            index =
                                (index - 1).clamp(0, currentWeekly.length - 1);
                            date = currentWeekly[index].name;
                          } else if (showMonthly) {
                            index =
                                (index - 1).clamp(0, currentMonthly.length - 1);
                            date = currentMonthly[index].name;
                          } else if (showYearly) {
                            index =
                                (index - 1).clamp(0, currentYearly.length - 1);
                            date = currentYearly[index].year.year.toString();
                          }
                        });
                      },
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: AppColors.colorAccent,
                        fontSize: 30,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.colorAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          if (showDaily) {
                            index =
                                (index + 1).clamp(0, currentDaily.length - 1);
                            date = currentDaily[index].day.toString();
                          } else if (showWeekly) {
                            index =
                                (index + 1).clamp(0, currentWeekly.length - 1);
                            date = currentWeekly[index].name;
                          } else if (showMonthly) {
                            index =
                                (index + 1).clamp(0, currentMonthly.length - 1);
                            date = currentMonthly[index].name;
                          } else if (showYearly) {
                            index =
                                (index + 1).clamp(0, currentYearly.length - 1);
                            date = currentYearly[index].year.year.toString();
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.colorPrimaryDark.withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ], 
                  ),
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: showDaily
                      ? (currentDaily.isNotEmpty && index < currentDaily.length)
                          ? DailyGraph(hourlyList: currentDaily[index].hourList)
                          : DailyGraph(hourlyList: [])
                      : (showWeekly
                          ? (currentWeekly.isNotEmpty &&
                                  index < currentWeekly.length)
                              ? DailyGraph(
                                  dailyList: currentWeekly[index].dailyList)
                              : DailyGraph(dailyList: [])
                          : (showMonthly
                              ? (currentMonthly.isNotEmpty &&
                                      index < currentMonthly.length)
                                  ? DailyGraph(
                                      weeklyList:
                                          currentMonthly[index].weeklyList)
                                  : DailyGraph(weeklyList: [])
                              : (currentYearly.isNotEmpty &&
                                      index < currentYearly.length)
                                  ? DailyGraph(
                                      monthlyList:
                                          currentYearly[index].monthlyList)
                                  : DailyGraph(monthlyList: []))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.colorPrimary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          selectedData = "calories";
                          setState(() {
                            iconIndex = 0;
                          });
                        },
                        icon: Icon(
                          size: 30,
                          MaterialCommunityIcons.fire,
                          color: iconIndex == 0
                              ? AppColors.colorAccent
                              : Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.colorPrimary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          selectedData = "steps";
                          setState(() {
                            iconIndex = 1;
                          });
                        },
                        icon: Icon(
                          MaterialCommunityIcons.shoe_print,
                          size: 30,
                          color: iconIndex == 1
                              ? AppColors.colorAccent
                              : Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.colorPrimary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          selectedData = "distance";
                          setState(() {
                            iconIndex = 2;
                          });
                        },
                        icon: Icon(
                          size: 30,
                          Icons.place_outlined,
                          color: iconIndex == 2
                              ? AppColors.colorAccent
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlurryContainer(
                blur: 90,
                elevation: 10,
                color: AppColors.colorPrimaryDark.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translatedStrings[widget.currentLanguage]![
                                    "totalcalsburn"] ??
                                AppStrings.totalCalsBurnt,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            translatedStrings[widget.currentLanguage]![
                                    "totalstepstaken"] ??
                                AppStrings.totalStepsTaken,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            translatedStrings[widget.currentLanguage]![
                                    "totaldistancecovered"] ??
                                AppStrings.totalDistanceCovered,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            translatedStrings[widget.currentLanguage]![
                                    "avgcalburned"] ??
                                AppStrings.avgCalBurned,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 1,
                      color: AppColors.blueLight,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${calories.toStringAsFixed(1)} kcal",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            steps.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${distance.toStringAsFixed(1)} m",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${avgCal.toStringAsFixed(1)} kcal",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Daily> dummyDaily = List<Daily>.generate(7, (index) {
    // Generate a list of hourly data for each day
    List<Hour> hourList = List<Hour>.generate(24, (hourIndex) {
      return Hour(
        hour: hourIndex,
        steps: 0, // Replace with your desired dummy data
        calories: 0, // Replace with your desired dummy data
        distance: 0, // Replace with your desired dummy data
      );
    });

    // Create a Daily object for each day of the week
    String dayName = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ][index];

    return Daily(
      hourList: hourList,
      day: dayName,
    );
  });

  List<Weekly> dummyWeekly = List<Weekly>.generate(4, (index) {
    // Generate a list of daily data for each week
    List<Daily> weekDays = List<Daily>.generate(7, (dayIndex) {
      // Generate a list of hourly data for each day
      List<Hour> hourList = List<Hour>.generate(24, (hourIndex) {
        // Replace the dummy values with your desired values for steps, calories, and distance
        int steps = (dayIndex + hourIndex) * 100;
        double calories = (dayIndex + hourIndex) * 10.0;
        double distance = (dayIndex + hourIndex) * 0.5;

        return Hour(
          hour: hourIndex,
          steps: steps,
          calories: calories,
          distance: distance,
        );
      });

      // Create a Daily object for each day of the week
      String dayName = [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ][dayIndex];

      return Daily(
        hourList: hourList,
        day: dayName,
      );
    });

    // Create a Weekly object for each week
    DateTime startDate = DateTime.now(); // Replace with your actual start date
    DateTime endDate =
        startDate.add(Duration(days: 6)); // Add 6 days instead of 7
    String weekName =
        '${DateFormat('MMMM d').format(startDate)} - ${DateFormat('MMMM d').format(endDate)}';

    // Calculate the total steƒps, calories, distance, and average calories for the weekly data
    int steps = weekDays.fold(0, (sum, daily) => sum + daily.steps);
    double calories = weekDays.fold(0.0, (sum, daily) => sum + daily.calories);
    double distance = weekDays.fold(0.0, (sum, daily) => sum + daily.distance);

    return Weekly(
      name: weekName,
      startDate: startDate,
      endDate: endDate,
      dailyList: weekDays,
      steps: steps,
      calories: calories,
      distance: distance,
    );
  });

  List<Monthly> dummyMonthly = List<Monthly>.generate(3, (index) {
    // Generate a list of weekly data for each month
    List<Weekly> monthWeeks = List<Weekly>.generate(4, (weekIndex) {
      // Generate a list of daily data for each week
      List<Daily> weekDays = List<Daily>.generate(7, (dayIndex) {
        // Generate a list of hourly data for each day
        List<Hour> hourList = List<Hour>.generate(24, (hourIndex) {
          // Replace the dummy values with your desired values for steps, calories, and distance
          int steps = (weekIndex + dayIndex + hourIndex) * 100;
          double calories = (weekIndex + dayIndex + hourIndex) * 10.0;
          double distance = (weekIndex + dayIndex + hourIndex) * 0.5;

          return Hour(
            hour: hourIndex,
            steps: steps,
            calories: calories,
            distance: distance,
          );
        });

        // Create a Daily object for each day of the week
        String dayName = [
          'Mon',
          'Tue',
          'Wed',
          'Thu',
          'Fri',
          'Sat',
          'Sun',
        ][dayIndex];

        return Daily(
          hourList: hourList,
          day: dayName,
        );
      });

      // Create a Weekly object for each week
      DateTime startDate =
          DateTime.now(); // Replace with your actual start date
      DateTime endDate =
          startDate.add(Duration(days: 6)); // Add 6 days instead of 7
      String weekName =
          '${DateFormat('MMMM d').format(startDate)} - ${DateFormat('MMMM d').format(endDate)}';

      // Calculate the total steƒps, calories, distance, and average calories for the weekly data
      int steps = weekDays.fold(0, (sum, daily) => sum + daily.steps);
      double calories =
          weekDays.fold(0.0, (sum, daily) => sum + daily.calories);
      double distance =
          weekDays.fold(0.0, (sum, daily) => sum + daily.distance);

      return Weekly(
        name: weekName,
        startDate: startDate,
        endDate: endDate,
        dailyList: weekDays,
        steps: steps,
        calories: calories,
        distance: distance,
      );
    });

    // Create a Monthly object for each month
    String monthName = DateFormat('MMMM').format(DateTime.now());

    // Calculate the total steps, calories, distance, and average calories for the monthly data
    int steps = monthWeeks.fold(0, (sum, weekly) => sum + weekly.steps);
    double calories =
        monthWeeks.fold(0.0, (sum, weekly) => sum + weekly.calories);
    double distance =
        monthWeeks.fold(0.0, (sum, weekly) => sum + weekly.distance);

    return Monthly(
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        weeklyList: monthWeeks,
        steps: steps,
        calories: calories,
        distance: distance,
        name: monthName);
  });
}
