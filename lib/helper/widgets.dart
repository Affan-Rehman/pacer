// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, library_private_types_in_public_api, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:alxgration_speedometer/speedometer.dart';
import 'package:geolocator/geolocator.dart';

import '../constants.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// Here import the files you need, like the appstrings file and WeatherIconHelper file

class WeatherWidget extends StatefulWidget {
  final String? currentLanguage;

  WeatherWidget({this.currentLanguage});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;
  String temp = '--';
  String humidity = '--';
  String sunrise = '--';
  String sunset = '--';
  IconData weatherIcon = Icons.sunny;
  String time = '--';

  bool _isCancelled = false;

  Future<void> updateWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final uri = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': '${position.latitude}',
        'lon': '${position.longitude}',
        'appid': AppStrings.openWeatherMapsApi,
      },
    );

    final response = await http.get(uri);

    if (!_isCancelled && response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var temperature = jsonResponse['main']['temp'];
      var hum = jsonResponse['main']['humidity'];
      var sunRise = jsonResponse['sys']['sunrise'];
      var sunSet = jsonResponse['sys']['sunset'];
      var w = jsonResponse['weather'][0]['main'];
      var icon = WeatherIconHelper.getWeatherIcon(w);

      if (mounted) {
        setState(() {
          temp = (temperature - 273.15).toStringAsFixed(2);
          humidity = hum.toString();
          sunrise =
              formatTime(DateTime.fromMillisecondsSinceEpoch(sunRise * 1000));
          sunset =
              formatTime(DateTime.fromMillisecondsSinceEpoch(sunSet * 1000));
          weatherIcon = icon;
          time = formatTime(DateTime.now());
        });
      }
    }
  }

  String formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    if (dateTime.hour > 12) {
      hour = dateTime.hour - 12;
    }
    String SHour = hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = dateTime.hour < 12 ? 'AM' : 'PM';

    return '$SHour:$minute $period';
  }

  @override
  void initState() {
    super.initState();
    updateWeather();
  }

  @override
  void dispose() {
    _isCancelled = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    weatherIcon,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('$temp°C',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17)),
                ],
              ),
              Text(
                  translatedStrings[widget.currentLanguage!]!['humidity']! +
                      ": $humidity",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17)),
              Text(
                  translatedStrings[widget.currentLanguage!]!['sunrise']! +
                      ": $sunrise",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              Text(
                  translatedStrings[widget.currentLanguage!]!['sunset']! +
                      ": $sunset",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class CompassWidget extends StatefulWidget {
  @override
  _CompassWidgetState createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  double? _direction;
  StreamSubscription<CompassEvent>? _compassSubscription;

  @override
  void initState() {
    super.initState();
    _listenDirection();
  }

  // Function to start listening to changes in direction
  void _listenDirection() {
    _compassSubscription = FlutterCompass.events!.listen((CompassEvent data) {
      setState(() {
        _direction = data.heading;
      });
    });
  }

  @override
  void dispose() {
    _compassSubscription?.cancel(); // Cancel the subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _direction != null
        ? Transform.rotate(
            angle: ((_direction ?? 0) * (math.pi / 180) * -1),
            child: Image.asset('assets/drawable/compass.png'),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

class SpeedometerWidget extends StatelessWidget {
  final double speed;

  SpeedometerWidget({Key? key, required this.speed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int speedValue = speed.toInt();

    return Speedometer(
      minValue: 0,
      maxValue: 200,
      currentValue: speedValue,
      pointerColor: Colors.white,
      barColor: AppColors.colorPrimaryDark,
      displayText: 'km/h',
    );
  }
}

class WeatherIconHelper {
  static const Map<String, IconData> weatherIcons = {
    'Thunderstorm': Icons.flash_on,
    'Drizzle': Icons.grain,
    'Rain': Icons.beach_access,
    'Snow': Icons.ac_unit,
    'Clear': Icons.wb_sunny,
    'Clouds': Icons.cloud,
    'Mist': Icons.blur_on,
    'Smoke': Icons.smoke_free,
    'Haze': Icons.filter,
    'Dust': Icons.cloud_queue,
    'Fog': Icons.cloud,
    'Sand': Icons.grain,
    'Ash': Icons.cloud_circle,
    'Squall': Icons.dehaze,
    'Tornado': Icons.nature,
  };

  static IconData getWeatherIcon(String weatherCondition) {
    return weatherIcons[weatherCondition] ?? Icons.error;
  }
}
