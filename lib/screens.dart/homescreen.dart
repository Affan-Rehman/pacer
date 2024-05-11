// ignore_for_file: unused_field, library_private_types_in_public_api, avoid_print, unused_element, prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pacer/constants.dart';
import 'package:uuid/uuid.dart';
import '../helper/classes.dart';
import '../widgets/dialog.dart';
import 'mainscreen.dart';

var uuid = const Uuid();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initiate global variables at the class level
  bool permission = false;
  bool trackingActive =
      false; // to keep track whether tracking is active or not
  String? walkStartTime, walkFinishTime;
  Walk? currentWalk;
  String walkId = uuid.v1();
  String currentLanguage = "en";
  bool isGranted = false;
  final StreamController<PedestrianStatus> _pedestrianStatusController =
      StreamController<PedestrianStatus>.broadcast();
  late StreamSubscription<PedestrianStatus> _pedestrianStatusSubscription;
  DateTime? walkingStartTime;
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;

  late Stream<PedestrianStatus> _pedestrianStatusStream;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset(
              'assets/drawable/splash_bg.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            buildLayout()
          ],
        ),
      ),
    );
  }

  void showNoLoginDialog(BuildContext context, VoidCallback ontap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoLoginDialog(onPressed: ontap);
      },
    );
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
        }
        walkingStartTime = null; // Reset the walking start time
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initpedometer();
    _loadCurrentLanguage();
    _updatePermissionStatus();
  }

  initpedometer() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
  }

  void _showPermissionDeniedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          translatedStrings[currentLanguage]!['permissionDenied'] ??
              'Permission denied',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showPermissionSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          translatedStrings[currentLanguage]!['permissionRequired'] ??
              'Permission required',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget buildLayout() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 24, 66, 107),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    translatedStrings[currentLanguage]!['appName'] ??
                        AppStrings.appName,
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Weather',
                    ),
                  ),
                  Text(
                    translatedStrings[currentLanguage]!['slogan'] ??
                        AppStrings.slogan,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Weather',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AnimationConfiguration.synchronized(
                            duration: const Duration(milliseconds: 300),
                            child: FadeInAnimation(
                              child: DialogLanguages(
                                onLanguageSelected: setLanguage,
                                currentLanguage: currentLanguage,
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.language),
                      color: AppColors.colorAccent,
                      iconSize: 32,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      AppStrings.language,
                      style: TextStyle(
                        fontFamily: 'Weather',
                        color: AppColors.colorAccent,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.56),
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                onPressed: () async {
                  bool isGranted = await _checkPermissions();
                  if (Platform.isIOS) {
                    permission = true;
                  }
                  if (isGranted && permission) {
                    _navigateToNextScreen();
                  } else {
                    if (!isGranted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Location permission required'),
                          action: SnackBarAction(
                              label: translatedStrings[currentLanguage]![
                                      'GOTOSETTINGS'] ??
                                  AppStrings.goToSettings,
                              onPressed: openAppSettings),
                        ),
                      );
                      await _checkPermissions();
                    }
                    if (!permission) {
                      if (Platform.isAndroid) {
                        permissionSteps();
                      }
                    }
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppColors.colorAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          translatedStrings[currentLanguage]!['letsgo'] ??
                              AppStrings.letsgo,
                          style: const TextStyle(
                            fontFamily: 'Weather',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _updatePermissionStatus() async {
    bool _isGranted = await _checkPermissions();
    if (!_isGranted) {
      _showPermissionDeniedSnackBar();
      await Future.delayed(const Duration(seconds: 2));
      AppSettings.openAppSettings();
    }
    setState(() {
      isGranted = _isGranted;
    });
  }

  void _loadCurrentLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentLanguage = prefs.getString('currentLanguage') ?? 'en';
    });
  }

  void setLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentLanguage', languageCode);
    setState(() {
      currentLanguage = languageCode;
    });
  }

  Future<void> permissionSteps() async {
    permission = await Permission.activityRecognition.request().isGranted;
    if (permission) {
      permission = true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enable location services'),
          action: SnackBarAction(
              label: translatedStrings[currentLanguage]!['GOTOSETTINGS'] ??
                  AppStrings.goToSettings,
              onPressed: openAppSettings),
        ),
      );
    }
    if (!mounted) return;
  }

  Future<bool> _checkPermissions() async {
    bool permissionallowed = false;
    bool _serviceEnabled;
    LocationPermission _permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enable location services'),
          action: SnackBarAction(
              label: translatedStrings[currentLanguage]!['GOTOSETTINGS'] ??
                  AppStrings.goToSettings,
              onPressed: openAppSettings),
        ),
      );
      return false;
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location permissions are required'),
            action: SnackBarAction(
                label: translatedStrings[currentLanguage]!['GOTOSETTINGS'] ??
                    AppStrings.goToSettings,
                onPressed: openAppSettings),
          ),
        );
        permissionallowed = false;
      } else if (_permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location permissions are permanently denied'),
            action: SnackBarAction(
                label: translatedStrings[currentLanguage]!['GOTOSETTINGS'] ??
                    AppStrings.goToSettings,
                onPressed: openAppSettings),
          ),
        );
        permissionallowed = false;
      } else {
        permissionallowed = true;
      }
    } else if (_permission == LocationPermission.deniedForever) {
      permissionallowed = false;
    } else {
      permissionallowed = true;
    }

    return permissionallowed;
  }

  void _navigateToNextScreen() {
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return NoLoginDialog(onPressed: showLoginDialog);
          },
        );
      });
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: MainScreen(currentLanguage),
            );
          },
        ),
      );
    }
  }

  void showLoginDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return LoginDialog();
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/drawable/splash_bg.png',
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Text(
                    AppStrings.translations['en']!['appName'] ??
                        AppStrings.appName,
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Weather',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
