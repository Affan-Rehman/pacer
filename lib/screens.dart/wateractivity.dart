// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:pacer/constants.dart';
import 'package:pacer/widgets/drawable_glass.dart';

class WaterActivity extends StatefulWidget {
  @override
  _WaterActivityState createState() => _WaterActivityState();
}

int water = 0;

class _WaterActivityState extends State<WaterActivity> {
  void incrementWater() {
    setState(() {
      water++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/drawable/home_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).clearSnackBars();
              },
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Water",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Water Drank: $water glasses",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                DraggableGlass(),
                SizedBox(height: 20),
                DragTarget(
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: AppColors.colorPrimary,
                      child: Center(
                        child: Text(
                          "Drop here",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  onWillAccept: (data) => data == 'glass',
                  onAccept: (data) {
                    incrementWater();
                  },
                  onLeave: (data) {},
                ),
                SizedBox(height: 20),
                Text(
                  "Drag glass to increase water drank",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
