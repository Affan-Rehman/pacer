// ignore_for_file: must_be_immutable, prefer_const_constructors,ignore_for_file:, use_key_in_widget_constructors, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants.dart';
import '../helper/classes.dart';

// ignore_for_file:
String selectedData = 'steps';

class DailyGraph extends StatefulWidget {
  final List<Hour>? hourlyList;
  final List<Daily>? dailyList;
  final List<Weekly>? weeklyList;
  final List<Monthly>? monthlyList;
  final List<Yearly>? yearlyList;

  const DailyGraph({
    this.hourlyList,
    this.dailyList,
    this.weeklyList,
    this.monthlyList,
    this.yearlyList,
  });
  static _DailyGraphState? of(BuildContext context) =>
      context.findAncestorStateOfType<_DailyGraphState>();

  @override
  _DailyGraphState createState() => _DailyGraphState();
}

class _DailyGraphState extends State<DailyGraph> {
  @override
  Widget build(BuildContext context) {
    List<_ChartData> data = [];

    if (widget.hourlyList != null && widget.hourlyList!.isNotEmpty) {
      data = widget.hourlyList!.map((_entry) {
        return _ChartData(
          'H ${_entry.hour}',
          _entry.steps.toDouble(),
          _entry.calories,
          _entry.distance,
        );
      }).toList();
    } else if (widget.dailyList != null && widget.dailyList!.isNotEmpty) {
      data = widget.dailyList!.map((_entry) {
        return _ChartData(
          _entry.day,
          _entry.steps.toDouble(),
          _entry.calories,
          _entry.distance,
        );
      }).toList();
    } else if (widget.weeklyList != null && widget.weeklyList!.isNotEmpty) {
      data = widget.weeklyList!.asMap().entries.map((_entry) {
        final int index = _entry.key;
        final Weekly weekly = _entry.value;
        return _ChartData(
          'Week ${index + 1}',
          weekly.steps.toDouble(),
          weekly.calories,
          weekly.distance,
        );
      }).toList();
    } else if (widget.monthlyList != null && widget.monthlyList!.isNotEmpty) {
      data = widget.monthlyList!.asMap().entries.map((_entry) {
        final Monthly monthly = _entry.value;
        return _ChartData(
          monthly.name,
          monthly.steps.toDouble(),
          monthly.calories,
          monthly.distance,
        );
      }).toList();
    } else if (widget.yearlyList != null && widget.yearlyList!.isNotEmpty) {
      data = widget.yearlyList!.asMap().entries.map((_entry) {
        final Yearly yearly = _entry.value;
        return _ChartData(
          yearly.year.year.toString(),
          yearly.steps.toDouble(),
          yearly.calories,
          yearly.distance,
        );
      }).toList();
    }

    return _buildChart(data);
  }

  Widget _buildChart(List<_ChartData> data) {
    return SfCartesianChart(
      title: ChartTitle(
          text: selectedData,
          textStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(color: Colors.white),
        majorGridLines:
            MajorGridLines(width: 0), // Remove the vertical grid lines
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<_ChartData, String>>[
        ColumnSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (_ChartData data, _) => data.xAxis,
          yValueMapper: (_ChartData data, _) => getDataValue(data),
          color: AppColors.pinkGraph,
        ),
      ],
    );
  }

  double getDataValue(_ChartData data) {
    switch (selectedData) {
      case 'steps':
        return data.steps;
      case 'calories':
        return data.calories;
      case 'distance':
        return data.distance;
      default:
        return 0;
    }
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}

class _ChartData {
  final String xAxis;
  final double steps;
  final double calories;
  final double distance;

  _ChartData(
    this.xAxis,
    this.steps,
    this.calories,
    this.distance,
  );
}

class GraphWidget extends StatefulWidget {
  final List<DayData> weekData;

  var currentLanguage;

  GraphWidget(this.weekData, this.currentLanguage);

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;
  @override
  Widget build(BuildContext context) {
    List<ChartData> data = widget.weekData.asMap().entries.map((_entry) {
      final int index = _entry.key;
      final DayData dayData = _entry.value;
      return ChartData(
        getDayInitial(index),
        dayData.steps,
        dayData.calories,
        dayData.distance,
      );
    }).toList();

    return SfCartesianChart(
      title: ChartTitle(
          text: translatedStrings[widget.currentLanguage]!['goal'] ??
              AppStrings.goal,
          textStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      plotAreaBorderWidth: 0, // Remove the square grid
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(color: Colors.white),
        majorGridLines:
            MajorGridLines(width: 0), // Remove the vertical grid lines
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: getMaxValue() + 2000,
        interval: 500,
        labelStyle: TextStyle(color: Colors.white),
        majorGridLines:
            MajorGridLines(width: 0), // Remove the horizontal grid lines
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        textStyle: TextStyle(color: Colors.white),
      ),
      series: <ChartSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.dayName,
          yValueMapper: (ChartData data, _) => data.steps,
          name: translatedStrings[widget.currentLanguage]!['steps'] ??
              AppStrings.steps,
          color: Color.fromRGBO(255, 176, 56, 1), // Light Orange
        ),
        ColumnSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.dayName,
          yValueMapper: (ChartData data, _) => data.calories,
          name: translatedStrings[widget.currentLanguage]!['goal_cals'] ??
              AppStrings.goalCals,
          color: Color.fromRGBO(101, 193, 166, 1), // Light Green
        ),
        ColumnSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.dayName,
          yValueMapper: (ChartData data, _) => data.distance,
          name: translatedStrings[widget.currentLanguage]!['goal_distance'] ??
              AppStrings.goalDistance,
          color: Color.fromRGBO(151, 101, 194, 1), // Light Purple
        ),
      ],
    );
  }

  double getMaxValue() {
    double maxValue = 0;

    for (var dayData in widget.weekData) {
      if (dayData.steps > maxValue) {
        maxValue = dayData.steps;
      }
      if (dayData.calories > maxValue) {
        maxValue = dayData.calories;
      }
      if (dayData.distance > maxValue) {
        maxValue = dayData.distance;
      }
    }

    return maxValue;
  }

  String getDayInitial(int index) {
    switch (index) {
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thu';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      case 6:
        return 'Sun';
      default:
        return '';
    }
  }
}

class ChartData {
  final String dayName;
  final double steps;
  final double calories;
  final double distance;

  ChartData(
    this.dayName,
    this.steps,
    this.calories,
    this.distance,
  );
}
