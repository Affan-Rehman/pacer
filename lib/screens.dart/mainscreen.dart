// ignore_for_file: prefer_const_constructors, must_be_immutable, sized_box_for_whitespace, use_key_in_widget_constructors, no_logic_in_create_state, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pacer/constants.dart';
import 'package:pacer/widgets/drawer.dart';
import 'package:pacer/screens.dart/goalscreen.dart';
import 'package:pacer/screens.dart/historyscreen.dart';
import 'package:pacer/screens.dart/performancescreen.dart';
import 'package:pacer/screens.dart/trackscreen.dart';
import 'package:pacer/screens.dart/widgetscreen.dart';
import 'package:share_plus/share_plus.dart';

class MainScreen extends StatefulWidget {
  MainScreen(this.currentLanguage);
  String currentLanguage = "en";

  @override
  _MainScreenState createState() => _MainScreenState(currentLanguage);
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;
  _MainScreenState(this.currentLanguage);
  String currentLanguage;
  int selectedIndex = 2; // Start from 'Performance' tab

  List<String> tabTitles = [];

  @override
  Widget build(BuildContext context) {
    bool showPowerIcon = _tabController.index == 2;
    bool showOtherAction = _tabController.index == 3;
    bool showActionButton =
        _tabController.index == 4 && selectedIndex != 2; // Add this line

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
            backgroundColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              },
            ),
            title: Text(
              tabTitles[_tabController.index],
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              if (showPowerIcon) // Display power icon only for Performance tab
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blueLight,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          size: 20,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              if (showOtherAction) // Display other action for GoalScreen
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blueLight,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(
                          Icons.check,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ),
                ),
              if (showActionButton) // Add this condition
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blueLight,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(
                          Icons.share,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          String message = 'My Progress Update:\n\n'
                              'Calories: ${calories.toStringAsFixed(1)} kcal\n'
                              'Distance: ${distance.toStringAsFixed(1)} m\n'
                              'Average Calories: ${avgCal.toStringAsFixed(1)} kcal\n\n'
                              'Calculate your progress on Pacer: ${dotenv.get('APP_LINK')}';

                          Share.share(message);
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
          drawer: MyNavigationDrawer(currentLanguage, selectedIndex),
          body: TabBarView(
            controller: _tabController,
            children: [
              WidgetsScreen(currentLanguage: currentLanguage),
              TrackScreen(currentLanguage),
              PerformanceScreen(currentLanguage),
              GoalScreen(currentLanguage),
              HistoryScreen(currentLanguage),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: AppColors.colorPrimary,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: _buildTab(
                    translatedStrings[currentLanguage]!['widgets'] ??
                        AppStrings.widgets,
                    0,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: _buildTab(
                    translatedStrings[currentLanguage]!['track'] ??
                        AppStrings.track,
                    1,
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 1,
                  child: _buildTab(
                    translatedStrings[currentLanguage]!['goal'] ??
                        AppStrings.goal,
                    3,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: _buildTab(
                    translatedStrings[currentLanguage]!['history'] ??
                        AppStrings.history,
                    4,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "navigator",
            onPressed: () {
              _tabController.animateTo(2); // Will take to Performance tab
            },
            backgroundColor: selectedIndex == 2
                ? AppColors.colorAccent
                : AppColors.colorPrimary,
            elevation: 20.0,
            child: Icon(
              MaterialCommunityIcons.shoe_print,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      child: Card(
        elevation: 20,
        child: Container(
          height: 50,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index
                      ? AppColors.colorAccent
                      : Colors.white, // Keep it white for non-selected tabs
                ),
                duration: Duration(milliseconds: 300),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Initialize tabTitles here
    tabTitles = [
      translatedStrings[currentLanguage]!['widgets'] ?? AppStrings.widgets,
      translatedStrings[currentLanguage]!['track'] ?? AppStrings.track,
      translatedStrings[currentLanguage]!['performance'] ??
          AppStrings.performance,
      translatedStrings[currentLanguage]!['goal'] ?? AppStrings.goal,
      translatedStrings[currentLanguage]!['history'] ?? AppStrings.history
    ];

    _tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: 2,
    ); // Five tabs now including the Performance
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    setState(() {
      selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);

    _tabController.dispose();
    super.dispose();
  }
}
