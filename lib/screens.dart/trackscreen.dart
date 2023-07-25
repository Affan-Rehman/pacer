// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously, depend_on_referenced_packages, prefer_final_fields, unused_field, use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pedometer/pedometer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../constants.dart';
import '../helper/classes.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class TrackScreen extends StatefulWidget {
  TrackScreen(this.currentLanguage);
  String currentLanguage = "en";

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;
  final firestore = FirebaseFirestore.instance;
  List<String> placeTypes = [
    'Accounting',
    'Airport',
    'Amusement Park',
    'Aquarium',
    'Art Gallery',
    'ATM',
    'Bakery',
    'Bank',
    'Bar',
    'Beauty Salon',
    'Bicycle Store',
    'Book Store',
    'Bowling Alley',
    'Bus Station',
    'Cafe',
    'Campground',
    'Car Dealer',
    'Car Rental',
    'Car Repair',
    'Car Wash',
    'Casino',
    'Cemetery',
    'Church',
    'City Hall',
    'Clothing Store',
    'Convenience Store',
    'Courthouse',
    'Dentist',
    'Department Store',
    'Doctor',
    'Electrician',
    'Electronics Store',
    'Embassy',
    'Fire Station',
    'Florist',
    'Funeral Home',
    'Furniture Store',
    'Gas Station',
    'Gym',
    'Hair Care',
    'Hardware Store',
    'Hindu Temple',
    'Home Goods Store',
    'Hospital',
    'Insurance Agency',
    'Jewelry Store',
    'Laundry',
    'Lawyer',
    'Library',
    'Liquor Store',
    'Local Government Office',
    'Locksmith',
    'Lodging',
    'Meal Delivery',
    'Meal Takeaway',
    'Mosque',
    'Movie Rental',
    'Movie Theater',
    'Moving Company',
    'Museum',
    'Night Club',
    'Painter',
    'Park',
    'Parking',
    'Pet Store',
    'Pharmacy',
    'Physiotherapist',
    'Plumber',
    'Police',
    'Post Office',
    'Real Estate Agency',
    'Restaurant',
    'Roofing Contractor',
    'RV Park',
    'School',
    'Shoe Store',
    'Shopping Mall',
    'Spa',
    'Stadium',
    'Storage',
    'Store',
    'Subway Station',
    'Supermarket',
    'Synagogue',
    'Taxi Stand',
    'Train Station',
    'Transit Station',
    'Travel Agency',
    'Veterinary Care',
    'Zoo',
  ];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  Timer? timerPolyline;
  int intervalInSeconds = 10;
  List<LatLng> polylineCoordinates = [];
  LatLng startLocation = LatLng(27.6683619, 85.3101895);
  LatLng endLocation = LatLng(27.6688312, 85.3077329);
  var distance = 0.0;
  var steps = 0;
  var kcal = 0.0;
  late Stream<StepCount> _stepCountStream;
  String? walkStartTime, walkFinishTime;
  Walk? currentWalk;
  String walkId = uuid.v1();
  Position? lastPosition;
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  String selectedPlaceType = 'Accounting';
  final placeTypeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // Define a variable to track the current map type
  MapType _currentMapType = MapType.normal;
  Timer? _timer;

  StreamSubscription<StepCount>? _stepCountSubscription;

  @override
  void initState() {
    super.initState();
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    _initControllerAndPosition();
    loadPolylines();
    startTracking();
    timerPolyline = Timer.periodic(Duration(seconds: intervalInSeconds), (_) {
      _moveMapToCurrentPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 500,
                  child: Stack(
                    children: [
                      GoogleMap(
                        polylines: Set<Polyline>.of(polylines.values),
                        mapType: _currentMapType,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(33.6844, 73.0479),
                          zoom: 14.4746,
                        ),
                        markers: _markers,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorPrimaryDark,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add_location),
                                color: Colors.white,
                                onPressed: _onAddPlacePressed,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorPrimaryDark,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.layers_sharp),
                                color: Colors.white,
                                onPressed: () {
                                  _showMapTypeDialog();
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorPrimaryDark,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                color: Colors.white,
                                onPressed: () {
                                  mapController
                                      ?.animateCamera(CameraUpdate.zoomIn());
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorPrimaryDark,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.remove),
                                color: Colors.white,
                                onPressed: () {
                                  mapController
                                      ?.animateCamera(CameraUpdate.zoomOut());
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorPrimaryDark,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.bookmarks),
                                color: Colors.white,
                                onPressed: _onViewPlacesPressed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 9,
                        right: 9,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 37, 212, 157),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _goToInitialPosition();
                            },
                            icon: Icon(Icons.my_location),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            steps.toString(),
                            style: TextStyle(
                              color: AppColors.colorAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            translatedStrings[widget.currentLanguage]
                                    ?['steps'] ??
                                AppStrings.steps,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            distance.toString(),
                            style: TextStyle(
                              color: AppColors.colorAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "${translatedStrings[widget.currentLanguage]!['distance']}(km)",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            "$kcal kcal",
                            style: TextStyle(
                              color: AppColors.colorAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            translatedStrings[widget.currentLanguage]
                                    ?['calories'] ??
                                AppStrings.calories,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> savePolylinesToHive(Map<PolylineId, Polyline> polylines) async {
    final box = await Hive.openBox<Polyline>(
        'polylines'); // Replace 'polylines' with your desired box name
    await box.clear(); // Clear the box before adding new polylines

    for (final entry in polylines.entries) {
      final polylineId = entry.key;
      final polyline = entry.value;
      box.put(polylineId.value,
          polyline); // Use the PolylineId value as the key and the polyline object
    }
  }

  Future<Map<PolylineId, Polyline>> loadPolylinesFromHive() async {
    final box = await Hive.openBox<Polyline>('polylines');
    final polylinesMap = box.toMap();

    final loadedPolylines = <PolylineId, Polyline>{};
    polylinesMap.forEach((key, value) {
      if (key is String) {
        final polylineId = PolylineId(key);
        loadedPolylines[polylineId] = value;
      }
    });

    return loadedPolylines;
  }

  Future<void> loadPolylines() async {
    final loadedPolylines = await loadPolylinesFromHive();
    setState(() {
      polylines = loadedPolylines;
    });
  }

  Future<void> _moveMapToCurrentPosition() async {
    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mapController != null) {
      final currentLatLng = LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      );

      if (lastPosition != null) {
        // Create a new polylineCoordinates list and add the existing polyline coordinates
        List<LatLng> updatedPolylineCoordinates =
            List.from(polylineCoordinates);
        updatedPolylineCoordinates.add(currentLatLng);

        addPolyline(updatedPolylineCoordinates);
      }

      mapController!
          .animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: currentLatLng,
          ),
        );
      });

      lastPosition = currentPosition;
    }
  }

  Future<void> addPolyline(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");

    if (polylines.containsKey(id)) {
      Polyline existingPolyline = polylines[id]!;
      List<LatLng> updatedPoints = List.from(existingPolyline.points);
      updatedPoints.addAll(polylineCoordinates);

      Polyline updatedPolyline =
          existingPolyline.copyWith(pointsParam: updatedPoints);
      polylines[id] = updatedPolyline;
    } else {
      Polyline newPolyline = Polyline(
        polylineId: id,
        color: Colors.deepPurpleAccent,
        points: polylineCoordinates,
        width: 4,
      );

      polylines[id] = newPolyline;
    }

    await savePolylinesToHive(polylines);
    setState(() {});
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      steps = 0;
    });
  }

  void onStepCount(StepCount event) {
    setState(() {
      steps = event.steps;
      distance = (steps * 0.762) /
          1000; // Average stride length in meters, converted to kilometers
      distance = double.parse(
          distance.toStringAsFixed(1)); // Truncate to 1 decimal place
      kcal = double.parse((steps * 0.04).toStringAsFixed(1));
    });
  }

  void startTracking() {
    walkStartTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    distance = 0.0;
    steps = 0;
    kcal = 0;

    // Subscribe to the step count stream
    _stepCountSubscription = _stepCountStream.listen(onStepCount);

    // Start a timer that calls writeData() every 10 seconds
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      writeData();
    });
  }

  Future<void> writeData() async {
    double distanceInKM = distance / 1000;
    currentWalk = Walk(
      id: uuid.v1(),
      distance: distanceInKM,
      steps: steps,
      kcal: kcal,
      datetimeStart: walkStartTime!,
      datetimeFinish: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    );

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('walks').add(currentWalk!.toMap());

      Box<Walk> box = await Hive.openBox<Walk>('walks');
      await firestore.collection('walks').get().then((snapshot) {
        for (var doc in snapshot.docs) {
          final data = doc.data();
          final walk = Walk.fromMap(data);
          box.put(walk.id, walk);
        }
      });

      await box.clear();
    } else {
      Box<Walk> box = await Hive.openBox<Walk>('walks');
      await box.put(walkId, currentWalk!);
    }
  }

  Future<bool> _onWillPop() async {
    return true;
  }

  @override
  void dispose() {
    addressController.dispose();
    placeTypeController.dispose();
    timerPolyline?.cancel();
    super.dispose();
  }

  Future<void> _initControllerAndPosition() async {
    _getPlacesFromHive();
    _determinePosition();
  }

  void _determinePosition() async {
    lastPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (mapController != null) {
      _moveMapToCurrentPosition();
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (lastPosition != null) {
      _moveMapToCurrentPosition();
    }
  }

  void _goToInitialPosition() {
    _moveMapToCurrentPosition();
  }

  void _onAddPlacePressed() {
    addressController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.colorPrimaryDark,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    translatedStrings[widget.currentLanguage]!["addmyplace"] ??
                        AppStrings.addMyPlace,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: placeTypeController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: translatedStrings[widget.currentLanguage]![
                              "LocationName"] ??
                          AppStrings.locationName,
                      labelStyle: TextStyle(color: Colors.white60),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: addressController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: translatedStrings[widget.currentLanguage]![
                              "LocationAddress"] ??
                          AppStrings.LocationAddress,
                      labelStyle: TextStyle(color: Colors.white60),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppColors.colorPrimary,
                    value: selectedPlaceType,
                    style: TextStyle(color: Colors.white),
                    items: placeTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPlaceType = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a place type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      _addPlace();
                      addressController.clear(); // Clear the address text field
                    },
                    child: Text(
                      translatedStrings[widget.currentLanguage]!["save"] ??
                          AppStrings.save,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addPlace() async {
    final placeName = placeTypeController.text;
    final placeType = selectedPlaceType;
    final address = addressController.text;

    if (placeName.isNotEmpty && placeType.isNotEmpty && address.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {
          final Location location = locations.first;
          final place = Place(
            id: Uuid().v4(),
            name: placeName,
            type: placeType,
            address: address,
            latitude: location.latitude,
            longitude: location.longitude,
          );

          final placesBox = Hive.box<Place>('places');
          await placesBox.put(place.id, place);

          final marker = Marker(
            markerId: MarkerId(place.id),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: placeName, snippet: placeType),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
          setState(() {
            _markers.add(marker);
          });

          // Check internet connectivity
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            // Update Firebase
            await firestore
                .collection('places')
                .doc(place.id)
                .set(place.toMap());
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Place added successfully'),
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Address does not exist'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid address'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    }
  }

  void showAddressSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _getPlacesFromHive() {
    final placesBox = Hive.box<Place>('places');
    final places = placesBox.values.toList();

    setState(() {
      _markers.addAll(places.map((place) => _createMarkerFromPlace(place)));
    });
  }

  Marker _createMarkerFromPlace(Place place) {
    return Marker(
      markerId: MarkerId(place.id),
      position: LatLng(place.latitude, place.longitude),
      infoWindow: InfoWindow(title: place.name, snippet: place.type),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    );
  }

  void _onViewPlacesPressed() async {
    final placesBox = Hive.box<Place>('places');
    final places = placesBox.values.toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select a place'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return ListTile(
                title: Text(place.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    // Remove the place from Hive
                    await placesBox.delete(place.id);

                    // Delete the document from Firestore if internet connection is available
                    if (await _isInternetAvailable()) {
                      final firestore = FirebaseFirestore.instance;
                      await firestore
                          .collection('places')
                          .doc(place.id)
                          .delete();
                    }

                    setState(() {
                      // Remove the corresponding marker from the map
                      _markers.removeWhere(
                          (marker) => marker.markerId.value == place.id);

                      // Update the places list
                      places.removeAt(index);
                    });
                    // Update the list in the dialog
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                  final selectedPlaceLatLng =
                      LatLng(place.latitude, place.longitude);
                  mapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(selectedPlaceLatLng, 15));
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showMapTypeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.colorPrimaryDark,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMapTypeOption(
                    MapType.normal,
                    translatedStrings[widget.currentLanguage]!["defaultmap"] ??
                        AppStrings.defaultMap,
                    "assets/drawable/ic_default.png"),
                _buildMapTypeOption(
                    MapType.satellite,
                    translatedStrings[widget.currentLanguage]!["satelite"] ??
                        AppStrings.satellite,
                    "assets/drawable/ic_satellite.png"),
                _buildMapTypeOption(
                    MapType.terrain,
                    translatedStrings[widget.currentLanguage]!["terrain"] ??
                        AppStrings.terrain,
                    "assets/drawable/ic_terrain.png"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMapTypeOption(MapType mapType, String text, String image) {
    return InkWell(
      onTap: () {
        _updateMapType(mapType);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: Image.asset(image),
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateMapType(MapType mapType) {
    setState(() {
      _currentMapType = mapType;
    });

    String mapTypeName;
    switch (mapType) {
      case MapType.normal:
        mapTypeName = 'Normal';
        break;
      case MapType.satellite:
        mapTypeName = 'Satellite';
        break;
      case MapType.terrain:
        mapTypeName = 'Terrain';
        break;
      default:
        mapTypeName = 'Unknown';
        break;
    }

    showAddressSnackbar("Map Type: $mapTypeName");
  }

  Stream<int> convertStepCountStream(Stream<StepCount> stepCountStream) {
    return stepCountStream.map((stepCount) => stepCount.steps);
  }

  Future<bool> _isInternetAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No internet connection
    } else {
      return true; // Internet connection is available
    }
  }
}
