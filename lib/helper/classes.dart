import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Hour {
  int hour;
  int steps;
  double calories;
  double distance;

  Hour({
    required this.hour,
    required this.steps,
    required this.calories,
    required this.distance,
  });
}

class Daily {
  List<Hour> hourList;
  int steps;
  double calories;
  double distance;
  double avgCal = 0;
  String day;

  Daily({
    required this.hourList,
    required this.day,
  })  : steps = 0,
        calories = 0.0,
        distance = 0.0 {
    _calculateSteps();
    _calculateCalories();
    _calculateDistance();
    _calculateAvgCal();
  }

  void _calculateSteps() {
    steps = hourList.fold(0, (sum, hour) => sum + hour.steps);
  }

  void _calculateCalories() {
    calories = hourList.fold(0.0, (sum, hour) => sum + hour.calories);
  }

  void _calculateDistance() {
    distance = hourList.fold(0.0, (sum, hour) => sum + hour.distance);
  }

  void _calculateAvgCal() {
    avgCal = calories / hourList.length;
  }
}

class Weekly {
  DateTime startDate;
  DateTime endDate;
  List<Daily> dailyList;
  int steps;
  double calories;
  double distance;
  double avgCal = 0;
  String name;

  Weekly({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.dailyList,
    required this.steps,
    required this.calories,
    required this.distance,
  }) {
    _calculateSteps();
    _calculateCalories();
    _calculateDistance();
    _calculateAvgCal();
  }

  void _calculateSteps() {
    steps = dailyList.fold(0, (sum, daily) => sum + daily.steps);
  }

  void _calculateCalories() {
    calories = dailyList.fold(0.0, (sum, daily) => sum + daily.calories);
  }

  void _calculateDistance() {
    distance = dailyList.fold(0.0, (sum, daily) => sum + daily.distance);
  }

  void _calculateAvgCal() {
    avgCal = dailyList.fold(0.0, (sum, daily) => sum + daily.avgCal) /
        dailyList.length;
  }
}

class Monthly {
  DateTime startDate;
  DateTime endDate;
  List<Weekly> weeklyList;
  int steps;
  double calories;
  double distance;
  double avgCal = 0;
  String name;

  Monthly(
      {required this.startDate,
      required this.endDate,
      required this.weeklyList,
      required this.steps,
      required this.calories,
      required this.distance,
      required this.name}) {
    _calculateSteps();
    _calculateCalories();
    _calculateDistance();
    _calculateAvgCal();
  }

  void _calculateSteps() {
    steps = weeklyList.fold(0, (sum, weekly) => sum + weekly.steps);
  }

  void _calculateCalories() {
    calories = weeklyList.fold(0.0, (sum, weekly) => sum + weekly.calories);
  }

  void _calculateDistance() {
    distance = weeklyList.fold(0.0, (sum, weekly) => sum + weekly.distance);
  }

  void _calculateAvgCal() {
    avgCal = weeklyList.fold(0.0, (sum, weekly) => sum + weekly.avgCal) /
        weeklyList.length;
  }
}

class Yearly {
  DateTime year;
  List<Monthly> monthlyList;
  int steps;
  double calories;
  double distance;
  double avgCal = 0;

  Yearly({
    required this.year,
    required this.monthlyList,
    required this.steps,
    required this.calories,
    required this.distance,
  }) {
    _calculateSteps();
    _calculateCalories();
    _calculateDistance();
    _calculateAvgCal();
  }

  void _calculateSteps() {
    steps = monthlyList.fold(0, (sum, monthly) => sum + monthly.steps);
  }

  void _calculateCalories() {
    calories = monthlyList.fold(0.0, (sum, monthly) => sum + monthly.calories);
  }

  void _calculateDistance() {
    distance = monthlyList.fold(0.0, (sum, monthly) => sum + monthly.distance);
  }

  void _calculateAvgCal() {
    avgCal = monthlyList.fold(0.0, (sum, monthly) => sum + monthly.avgCal) /
        monthlyList.length;
  }
}

class Place {
  final String id;
  final String name;
  final String type;
  final String address;
  final double latitude;
  final double longitude;

  Place({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}

class Walk {
  final String id;
  final double distance;
  final int steps;
  final double kcal;
  final String datetimeStart;
  final String datetimeFinish;

  Walk({
    required this.id,
    required this.distance,
    required this.steps,
    required this.kcal,
    required this.datetimeStart,
    required this.datetimeFinish,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'distance': distance,
      'steps': steps,
      'kcal': kcal,
      'datetimestart': datetimeStart,
      'datetimefinish': datetimeFinish,
    };
  }

  factory Walk.fromMap(Map<String, dynamic> map) {
    return Walk(
      id: map['id'],
      distance: map['distance'],
      steps: map['steps'],
      kcal: map['kcal'],
      datetimeStart: map['datetimestart'],
      datetimeFinish: map['datetimefinish'],
    );
  }
}

class TrackData {
  int stepCount;
  double calorieCount;
  double distance;

  TrackData({this.stepCount = 0, this.calorieCount = 0.0, this.distance = 0.0});
}

class DayData {
  String name;
  double steps;
  double calories;
  double distance;

  DayData({
    required this.name,
    required this.steps,
    required this.calories,
    required this.distance,
  });
}

Future<bool> checkIfUserDocExists() async {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  await auth.currentUser!.reload();
  final userDoc =
      await fireStore.collection("users").doc(auth.currentUser!.uid).get();
  return userDoc.exists;
}
