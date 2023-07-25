// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:pacer/constants.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import '../helper/classes.dart';
import '../helper/graphs.dart';

class GoalScreen extends StatefulWidget {
  final String currentLanguage;

  const GoalScreen(this.currentLanguage);

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;

  List<DayData> weekData = List<DayData>.generate(
    7,
    (index) => DayData(
      name: getDayName(index),
      steps: 0,
      calories: 0,
      distance: 0,
    ),
  );
  int selectedDayIndex = 0;

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  7,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                        controllers[0].text =
                            weekData[selectedDayIndex].steps.toString();
                        controllers[1].text =
                            weekData[selectedDayIndex].calories.toString();
                        controllers[2].text =
                            weekData[selectedDayIndex].distance.toString();
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedDayIndex == index
                            ? AppColors.colorAccent
                            : AppColors.blueLight,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          getDayName(index),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: BlurryContainer(
                  blur: 90,
                  elevation: 10,
                  color: AppColors.colorPrimaryDark.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.blueLight,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    translatedStrings[widget.currentLanguage]![
                                            'steps'] ??
                                        AppStrings.steps,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.blueLight,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    translatedStrings[widget.currentLanguage]![
                                            'goal_cals'] ??
                                        AppStrings.goalCals,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text(
                                  translatedStrings[widget.currentLanguage]![
                                          'goal_distance'] ??
                                      AppStrings.goalDistance,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 170,
                        width: 1,
                        color: AppColors.blueLight,
                      ),

                      // Second column for input fields
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.blueLight,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: TextField(
                                controller: controllers[0],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    updateData(double.parse(value), 0);
                                    writeDataToHive(weekData);
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.blueLight,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: TextField(
                                controller: controllers[1],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d{0,2}$')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    updateData(double.parse(value), 1);
                                    writeDataToHive(weekData);
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextField(
                              controller: controllers[2],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  updateData(double.parse(value), 2);
                                  writeDataToHive(weekData);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(16.0),
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
                height: MediaQuery.of(context).size.height * 0.3,
                child: GraphWidget(weekData, widget.currentLanguage),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    controllers[0].text = weekData[selectedDayIndex].steps.toString();
    controllers[1].text = weekData[selectedDayIndex].calories.toString();
    controllers[2].text = weekData[selectedDayIndex].distance.toString();
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
      controllers[0].text = weekData[selectedDayIndex].steps.toString();
      controllers[1].text = weekData[selectedDayIndex].calories.toString();
      controllers[2].text = weekData[selectedDayIndex].distance.toString();
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

  void writeDataToHive(List<DayData> weekData) async {
    final box = await Hive.openBox<DayData>('weekData');
    await box.clear();
    await box.addAll(weekData);
  }

  void updateData(double value, int index) {
    setState(() {
      if (selectedDayIndex >= 0 && selectedDayIndex < weekData.length) {
        if (index == 0) {
          weekData[selectedDayIndex].steps = value;
          calculateCaloriesAndGoals();
          controllers[1].text =
              weekData[selectedDayIndex].calories.toStringAsFixed(2);
          controllers[2].text =
              weekData[selectedDayIndex].distance.toStringAsFixed(1);
        } else if (index == 1) {
          weekData[selectedDayIndex].calories = value;
          calculateStepsAndGoals();
          controllers[0].text = weekData[selectedDayIndex]
              .steps
              .toStringAsFixed(0)
              .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
          controllers[2].text =
              weekData[selectedDayIndex].distance.toStringAsFixed(1);
        } else if (index == 2) {
          weekData[selectedDayIndex].distance = value;
          calculateStepsAndCalories();
          controllers[0].text = weekData[selectedDayIndex]
              .steps
              .toStringAsFixed(0)
              .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
          controllers[1].text =
              weekData[selectedDayIndex].calories.toStringAsFixed(2);
        }
      }
    });
  }

  void calculateCaloriesAndGoals() {
    if (selectedDayIndex >= 0 && selectedDayIndex < weekData.length) {
      final steps = weekData[selectedDayIndex].steps;
      final distance = (steps * 0.762) / 1000;
      final calories = steps * 0.04;
      weekData[selectedDayIndex].calories = calories;
      weekData[selectedDayIndex].distance = distance;
    }
  }

  void calculateStepsAndGoals() {
    if (selectedDayIndex >= 0 && selectedDayIndex < weekData.length) {
      final calories = weekData[selectedDayIndex].calories;
      final distance = (calories / 0.04) / 0.762;
      final steps = calories / 0.04;
      weekData[selectedDayIndex].steps = steps;
      weekData[selectedDayIndex].distance = distance;
    }
  }

  void calculateStepsAndCalories() {
    if (selectedDayIndex >= 0 && selectedDayIndex < weekData.length) {
      final distance = weekData[selectedDayIndex].distance;
      final steps = (distance) / 0.762;
      final calories = steps * 0.04;
      weekData[selectedDayIndex].steps = steps;
      weekData[selectedDayIndex].calories = calories;
    }
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
