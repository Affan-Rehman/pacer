// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, depend_on_referenced_packages, use_key_in_widget_constructors
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import "package:intl/intl.dart";
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants.dart';
import '../helper/classes.dart';
import 'homescreen.dart';

class PerformanceScreen extends StatefulWidget {
  PerformanceScreen(this.currentLanguage);
  String currentLanguage = "en";

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  List<DateTime> weekDates = [];
  int selectedDayIndex = DateTime.now().weekday - 1;
  DateFormat dateFormat = DateFormat('dd/MM/yy');
  List<DayData> weekData = List<DayData>.generate(
    7,
    (index) => DayData(
      name: getDayName(index),
      steps: 0,
      calories: 0,
      distance: 0,
    ),
  );
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;
  var distance = 0.0;
  var steps = 0;
  bool isLocationEnabled = false;
  var kcal = 0.0;
  String date = "Today";
  var duration = 0.0;
  var goal = 15000; // Step count goal
  var percentage = 0.0; // Percentage of steps towards the goal
  Color locationIconColor =
      AppColors.colorAccent; // Initial color for the location icon

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'stopped';
  DateTime? walkingStartTime;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    checkLocationServiceContinuously();
    loadData();
    generateWeekDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
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
                        if (selectedDayIndex > 0) {
                          setState(() {
                            selectedDayIndex--;
                            goal = weekData[selectedDayIndex].steps.toInt();
                            percentage = (steps / goal) * 100;
                            if (percentage > 100) {
                              percentage = 100;
                            }
                          });
                        }
                      },
                    ),
                    Text(
                      dateFormat.format(weekDates[selectedDayIndex]),
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
                        if (selectedDayIndex < weekDates.length - 1) {
                          setState(() {
                            selectedDayIndex++;
                            goal = weekData[selectedDayIndex].steps.toInt();
                            percentage = (steps / goal) * 100;
                            if (percentage > 100) {
                              percentage = 100;
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimary.withOpacity(0.7),
                ),
                child: Material(
                  color: AppColors.colorPrimaryDark.withOpacity(0.5),
                  elevation: 15,
                  shape: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircularPercentIndicator(
                      radius: 140.0,
                      lineWidth: 10.0,
                      percent: (steps / goal) > 1
                          ? 1
                          : steps / goal, // Updated the percent calculation
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            steps.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            translatedStrings[widget.currentLanguage]![
                                    "steps"] ??
                                AppStrings.steps,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "${percentage.toStringAsFixed(1)}%", // Display the percentage value
                            style: TextStyle(
                                color: AppColors.colorAccent,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      progressColor: Colors.green,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<PedestrianStatus>(
                      stream: _pedestrianStatusStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<PedestrianStatus> snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          Icon icon = getIconBasedOnStatus(data.status);
                          String statusText = getStatusText(data.status);

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 16, 45, 73),
                                  ),
                                  child: icon,
                                ),
                              ),
                              Text(statusText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 16, 45, 73),
                                ),
                                child: getIconBasedOnStatus("stopped"),
                              ),
                            ),
                            Text(getStatusText("stopped"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ],
                        );
                      },
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  isLocationEnabled ? Colors.green : Colors.red,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                goToLocationSettings();
                              },
                            ),
                          ),
                        ),
                        Text(
                          isLocationEnabled
                              ? translatedStrings[widget.currentLanguage]![
                                      "tracking"] ??
                                  AppStrings.tracking
                              : translatedStrings[widget.currentLanguage]![
                                      "trackingstoped"] ??
                                  AppStrings.trackingStopped,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    translatedStrings[widget.currentLanguage]![
                                            "stepSensor"] ??
                                        AppStrings.stepSensor,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    translatedStrings[widget.currentLanguage]![
                                            "sensor_message"] ??
                                        AppStrings.sensorMessage,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      translatedStrings[widget
                                              .currentLanguage]!["gotit"] ??
                                          AppStrings.gotIt,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      translatedStrings[widget.currentLanguage]![
                              "stepinfo_detector"] ??
                          AppStrings.sensorInfoDetector,
                      style: TextStyle(
                        color: AppColors.colorAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.help_outline, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    translatedStrings[widget.currentLanguage]![
                                            "stepSensor"] ??
                                        AppStrings.stepSensor,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    translatedStrings[widget.currentLanguage]![
                                            "sensor_message"] ??
                                        AppStrings.sensorMessage,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      translatedStrings[widget
                                              .currentLanguage]!["gotit"] ??
                                          AppStrings.gotIt,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            distance.toString(),
                            style: TextStyle(
                              color: AppColors.colorAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "${translatedStrings[widget.currentLanguage]!['distance']} (km)",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            "$kcal kcal",
                            style: TextStyle(
                              color: AppColors.colorAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            translatedStrings[widget.currentLanguage]
                                    ?['calories'] ??
                                AppStrings.calories,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            duration.toString(),
                            style: TextStyle(
                              color: AppColors.colorAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "${translatedStrings[widget.currentLanguage]!['duration']} (hr)",
                            style: TextStyle(color: Colors.white, fontSize: 15),
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

  Future<void> loadData() async {
    await readDataFromHive().then((data) {
      if (data.isEmpty) {
        setState(() {
          weekData = List<DayData>.generate(
            7,
            (index) => DayData(
              name: getDayName(index),
              steps: 0,
              calories: 0,
              distance: 0,
            ),
          );
        });
      } else {
        setState(() {
          weekData = data;
        });
      }
    });
  }

  Future<List<DayData>> readDataFromHive() async {
    final box = await Hive.openBox<DayData>('weekData');

    if (box.isEmpty) {
      return List<DayData>.generate(
        7,
        (index) => DayData(
          name: getDayName(index),
          steps: 0,
          calories: 0,
          distance: 0,
        ),
      );
    }

    return box.values.toList();
  }

  Icon getIconBasedOnStatus(String status) {
    switch (status) {
      case 'walking':
        return Icon(
          Icons.directions_walk,
          size: 30,
          color: AppColors.colorAccent,
        );

      case 'stopped':
        return Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        );
      default:
        return Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        );
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'walking':
        return translatedStrings[widget.currentLanguage]!["walking"] ??
            AppStrings.walking;
      case 'stopped':
        return translatedStrings[widget.currentLanguage]!["staticposition"] ??
            AppStrings.staticPosition;
      default:
        return translatedStrings[widget.currentLanguage]!["staticposition"] ??
            AppStrings.staticPosition;
    }
  }

  void checkLocationServiceContinuously() {
    // Use periodic timer to check location service status every second
    Timer.periodic(Duration(seconds: 1), (timer) async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      setState(() {
        isLocationEnabled = serviceEnabled;
      });
    });
  }

  void goToLocationSettings() async {
    if (Platform.isIOS) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        bool serviceStatus = await Geolocator.openLocationSettings();
        if (!serviceStatus) {
          print('Failed to open location services');
        }
      }
    } else if (Platform.isAndroid) {
      await AppSettings.openLocationSettings();
    } else {
      print("Unsupported platform");
    }
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      steps = 0;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    if (event.status == 'walking') {
      walkingStartTime = event.timeStamp;
    } else {
      if (walkingStartTime != null) {
        final walkingEndTime = event.timeStamp;
        final walk = Walk(
          id: uuid.v1(),
          distance: 0.0, // Set distance to 0 or omit it if not needed
          steps: 0,
          kcal: 0.0, // Set kcal to 0 or omit it if not needed
          datetimeStart: walkingStartTime.toString(),
          datetimeFinish: walkingEndTime.toString(),
        );

        final box = Hive.box<Walk>('backup');
        if (!box.values.contains(walk)) {
          box.add(walk);
          log("Added");
        }
        walkingStartTime = null; // Reset the walking start time
      }
    }

    setState(() {
      _status = event.status;
    });
  }

  void onStepCount(StepCount event) {
    setState(() {
      steps = event.steps;
      distance = (steps * 0.762) / 1000;
      distance = double.parse(distance.toStringAsFixed(1));
      kcal = double.parse((steps * 0.04).toStringAsFixed(1));
      percentage = (steps / goal) * 100;
      if (percentage > 100) {
        percentage = 100;
      }
    });

    // Calculate total walking duration
    final box = Hive.box<Walk>('backup');
    double totalDuration = 0.0;
    for (var i = 0; i < box.length; i++) {
      final walk = box.getAt(i) as Walk;
      final startDateTime = DateTime.parse(walk.datetimeStart);
      final finishDateTime = DateTime.parse(walk.datetimeFinish);
      final durationInSeconds =
          finishDateTime.difference(startDateTime).inSeconds;
      final durationInHours = durationInSeconds / 3600;
      totalDuration += durationInHours;
    }

    // Format duration to hours and minutes
    final hours = totalDuration.floor();
    final minutes = ((totalDuration - hours) * 60).round();

    setState(() {
      duration = double.parse('$hours.$minutes');
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void generateWeekDates() {
    DateTime currentDate =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    for (int i = 0; i < 7; i++) {
      weekDates.add(currentDate.add(Duration(days: i)));
    }
  }

  void updateSelectedDay(int index) {
    setState(() {
      selectedDayIndex = index;
    });
  }

  static String getDayName(int index) {
    switch (index) {
      case 0:
        return 'M';
      case 1:
        return 'T';
      case 2:
        return 'W';
      case 3:
        return 'T';
      case 4:
        return 'F';
      case 5:
        return 'S';
      case 6:
        return 'S';
      default:
        return '';
    }
  }
}
