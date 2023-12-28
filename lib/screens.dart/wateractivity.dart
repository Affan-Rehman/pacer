// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pacer/constants.dart';

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
                ScaffoldMessenger.of(context)
            .clearSnackBars();
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

class DraggableGlass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data:
          'glass', // Data to send when the draggable is accepted by the target.
      child: Icon(
        MaterialCommunityIcons
            .glass_pint_outline, // You can replace this with any appropriate glass icon.
        color: Colors.blue,
        size: 40,
      ),
      feedback: Icon(
        MaterialCommunityIcons.glass_pint_outline,
        color: Colors.blue.withOpacity(0.7),
        size: 40,
      ),
      childWhenDragging: Icon(
        MaterialCommunityIcons.glass_pint_outline,
        color: Colors.grey,
        size: 40,
      ),
      onDragEnd: (details) {
        ScaffoldMessenger.of(context)
            .clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Water drank!'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }
}
