// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, library_private_types_in_public_api, no_logic_in_create_state, avoid_print, sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pacer/constants.dart';
import 'package:pacer/widgets/compass.dart';
import 'package:pacer/widgets/speedometer.dart';
import 'package:pacer/widgets/weather_widget.dart';

class WidgetsScreen extends StatefulWidget {
  final String currentLanguage;

  WidgetsScreen({required this.currentLanguage});

  @override
  _WidgetsScreenState createState() =>
      _WidgetsScreenState(currentLanguage: currentLanguage);
}

class _WidgetsScreenState extends State<WidgetsScreen> {
  String time = "";
  String humidity = "";
  String sunrise = "";
  String sunset = "";
  String temp = "";
  String address = "";
  double speed = 0;
  late String currentLanguage;
  StreamSubscription<Position>? _positionSubscription;
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;

  Timer? timer;
  Position? lastPosition;

  _WidgetsScreenState({required this.currentLanguage});

  @override
  void initState() {
    super.initState();
    _initPosition();
    _startListening();
  }

  void _initPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    _updateAddress(position);
  }

  void _startListening() {
    _positionSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      if (!mounted) return;
      setState(() {
        lastPosition = position;
        double tempSpeed = position.speed * 3.6;
        if (tempSpeed < 0) tempSpeed = 0;
        speed = tempSpeed;

        _updateAddress(position);
      });
    });
  }

  Future<void> _updateAddress(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      }
    } catch (e) {
      print('Failed to get address: $e');
    }
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                  height: 120,
                  child: WeatherWidget(currentLanguage: currentLanguage),
                ),
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
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      translatedStrings[widget.currentLanguage]![
                              'LocationAddress']! +
                          ": $address",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 230,
                            height: 200,
                            child: CompassWidget(),
                          ),
                        ),
                        Text(
                          translatedStrings[widget.currentLanguage]![
                                  'direction'] ??
                              AppStrings.direction,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 150,
                            height: 150,
                            child: SpeedometerWidget(speed: speed),
                          ),
                        ),
                        Text(
                          translatedStrings[widget.currentLanguage]!['speed'] ??
                              AppStrings.speed,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
