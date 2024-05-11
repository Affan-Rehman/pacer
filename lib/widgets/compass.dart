// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, library_private_types_in_public_api, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:async';
import 'dart:math' as math;

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
