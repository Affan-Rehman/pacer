// ignore_for_file: use_full_hex_values_for_flutter_colors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppColors {
  static const Color colorPrimary = Color(0xFF163B5F);
  static const Color colorPrimaryDark = Color(0xFF001535);
  static const Color colorAccent = Color.fromRGBO(8, 192, 133, 1);
  static const Color colorAccentSemi = Color(0xFF8808C085);
  static const Color primarySlightLight = Color(0xFF25537E);
  static const Color gPrimaryLight = Color(0xFF2F6393);
  static const Color gPrimaryDark = Color(0xFF012347);
  static const Color primaryLight = Color(0xFF627183);
  static const Color semiblue = Color(0xFFAA182F4A);
  static const Color semiblue4 = Color(0xFF44182F4A);
  static const Color redNew = Color(0xFFEB4D4B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color blueLight = Color(0xFF7771B2FF);
  static const Color tbgColorDefaultMarker = colorAccent;
  static const Color bgLight = Color(0xFFF0F3FF);
  static const Color dialogConfirm = Color(0xFFEF6C00);
  static const Color yo = Color(0x00000000);
  static const Color buttonBackground = Color(0xFF8356646D);
  static const Color textColorCode = Color(0xFF000000);
  static const Color help = Color(0xFF64000406);
  static const Color redLight = Color(0xFFE53935);
  static const Color buttons = Color(0xFFCFD8DC);
  static const Color lightGray = Color(0xFFD3D3D3);
  static const Color colorMarker = Color(0xFFF16157);
  static const Color colorMarkerStroke = Color(0xFFB6392F);
  static const Color red = Color(0xFFFF4081);
  static const Color speed = Color(0xFF33B5E5);
  static const Color height = Color(0xFF99CC00);
  static const Color stroke = Color(0xFF444444);
  static const Color meterback = Color(0xFF455A64);
  static const Color seagreen = Color(0xFF00E676);
  static const Color voilet = Color(0xFF4900A1);
  static const Color meroon = Color(0xFF8B0000);
  static const Color orangeDark = Color(0xFFEF6C00);
  static const Color yellow = Color(0xFFFFFF00);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color pinkGraph = Color(0xFFC964B4);
  static const Color warning = Color(0xFFF57C00);
  static const Color error = Color(0xFFFF5252);
}

class AppStrings {
  static const String water = "water";
  String googleMapsApi = dotenv.get('GOOGLE_MAPS_API');
  String openWeatherMapsAppId = dotenv.get('OPEN_WEATHER_MAPS_APP_ID');
  String appLink = dotenv.get('APP_LINK');
  String admobAppId = dotenv.get('ADMOB_APP_ID');
  String openWeatherMapsApi = dotenv.get('OPEN_WEATHER_MAPS_API');
  static const String appName = "Pacer";
  static const String appNamePacerBelowIcon = "Pacer";

  static const String sotwNorth = "N";
  static const String sotwEast = "E";
  static const String sotwSouth = "S";
  static const String sotwWest = "W";
  static const String sotwNorthEast = "NE";
  static const String sotwNorthWest = "NW";
  static const String sotwSouthEast = "SE";
  static const String sotwSouthWest = "SW";
  static const String logout = "Log Out";
  static const String weatherSunny = "\u{f00d}";
  static const String weatherClearNight = "\u{f02e}";
  static const String weatherFoggy = "\u{f014}";
  static const String weatherCloudy = "\u{f013}";
  static const String weatherRainy = "\u{f019}";
  static const String weatherSnowy = "\u{f01b}";
  static const String weatherThunder = "\u{f01e}";
  static const String weatherDrizzle = "\u{f01c}";
  static const String unknown = "Unknown";
  static const String slogan = "Be Fit, Be Healthy";
  static const String widgets = "Widgets";
  static const String history = "History";
  static const String goal = "Goal";
  static const String track = "Track";
  static const String helloBlankFragment = "Hello blank fragment";
  static const String performance = "Performance";
  static const String distance = "Distance";
  static const String calories = "Calories";
  static const String time = "Time";
  static const String tracking = "Tracking";
  static const String walking = "Walking";
  static const String steps = "Steps";
  static const String completed = "completed";
  static const String goalSetting = "Goal Setting";
  static const String goalCals = "Calories (kcal)";
  static const String goalSteps = "Steps";
  static const String goalDistance = "Distance (km)";
  static const String progress = "Progress";
  static const String totalCalsBurnt = "Total Calories Burnt";
  static const String totalStepsTaken = "Total Steps Taken";
  static const String totalDistanceCovered = "Total Distance Covered";
  static const String avgCalBurned = "Average Calories Burnt";
  static const String direction = "DIRECTION";
  static const String speed = "SPEED";
  static const String flashlight = "Flash Light";
  static const String daily = "Daily";
  static const String monthly = "Monthly";
  static const String weekly = "Weekly";
  static const String yearly = "Yearly";
  static const String moreApps = "More Apps";
  static const String shareApp = "Share App";
  static const String feedback = "Feedback";
  static const String likeUs = "Rate us";
  static const String privacyPolicy = "Privacy Policy";
  static const String website = "Website";
  static const String privacyText =
      "Charisma Apps (CA) provides Free Tools, Educational and Entertainment material mostly in the form of Apps for mobile devices. CA respects the privacy of the users of all its Applications especially their personal information such as contacts, photos, videos, textual messages or other saved contents throughout the lifetime of App usage.\n\nAccording any information collected, processed, saved or transmitted within the declared scope of the functions published in the App is done strictly with the approval, consent of the users. Most of the times, such events are initiated by the user himself/herself on every instance.\n\nWhile CA makes its best effort to safeguard the personal information mentioned above while stored on the device or in use by the App within its defined/declared scope, CA will not be responsible for any loss of information or data or any consequential loss/damage thereof due to any reason including malfunction of the host device or other malicious code or Apps running on it.\n\nFor more details visit our";
  static const String privacyUrl =
      "http://charismaapps.co/privacy%20policy.html";
  static const String email = "charismaapps@gmail.com";
  static const String goalSaved = "Goal updated sucessfully";
  static const String needPermissions = "Need Permissions";
  static const String needsPermission =
      "This app needs permission to use this feature. You can grant them in app settings.";
  static const String goToSettings = "GOTO SETTINGS";
  static const String cancel = "Cancel";
  static const String turnOff = "Turn Off";
  static const String sureToTurnOff =
      "Are you sure you want to Turn OFF Tracking?";
  static const String yes = "Yes";
  static const String no = "No";
  static const String serviceStopped = "Setps Counting as been Paused";
  static const String serviceStarted = "Pacer is tracking your walks now";
  static const String today = "Today";
  static const String running = "Running";
  static const String staticPosition = "Static";
  static const String highSpeed = "High Speed";
  static const String recordingTrack = "Tracking";
  static const String trackingStopped = "Tracking";
  static const String humidity = "Humidity";
  static const String sunrise = "Sunrise";
  static const String sunset = "Sunset";
  static const String addressNotFound = "No Address Found";
  static const String chooseMapType = "Choose Map Type";
  static const String terrain = "Terrain";
  static const String satellite = "Satellite";
  static const String defaultMap = "Default";
  static const String addMyPlace = "Add Place";
  static const String locationName = "Location Name";
  static const String LocationAddress = "Address";
  static const String selectCategory = "Select Category";
  static const String save = "Save";
  static const String fillFieldToProceed =
      "Please fill out this field to proceed";
  static const String placeAddedSuccessfully =
      "Your place has been successfully added";
  static const String letsgo = "Let's Go";
  static const String currentWeek = "Current Week";
  static const String errorAcquiringData = "Error Acquiring Data";
  static const String textShareImgBtm =
      "Keep walking and stay healthy with PACER";
  static const String chooseLanguage = "Choose Language";
  static const String ok = "Ok";
  static const String gotIt = "Got it";
  static const String welcome = "Welcome";
  static const String guidePerformance =
      "PACER allows you to track all the fitness basics whether it's counting your steps, maintain a distance check, burned calories or active time. You can follow your current performance on this screen. Also you can see records of previous days here. You can start/stop your performance tracking using the power button on top right of the screen. The circle on left shows the walking status that either you are walking, running or static. Circle on right shows either PACER is tracking your walk or not. While steps taken and goal achievement is shown in the middle one.";
  static const String guideGoal =
      "Here you can schedule and set your weekly fitness routine & Goals. Select the day and enter the value in any of the fields it will auto calculate the estimated value of other fields. Schedule chart is shown at the bottom that shows comparison between the goals scheduled for days of the week";
  static const String guideHistory =
      "Here you can get an overview of your weekly, monthly or yearly performance in the form of graphs. You can also share you performance by using share button at top right of the screen.";
  static const String guideTrack =
      "Here you can see the tracks recorded of current date on map. You can view map in Terrain and Satellite view by changing its type. You can also mark any place as your favorite place and share it or current location via any sharing media. Select place marker on map to share or delete it.";
  static const String guideWidgets =
      "This screen shows address, temperature, humidity, sunset/sunrise timings and direction of your current location. It also shows your current speed. You can turn ON/OFF flash light of your handset using \"Flash Light\" button";
  static const String textShareLoc =
      "Track your everyday's performance with PACER: A step counter and walk tracker Application";
  static const String deletePlace = "Delete Place";
  static const String deletePlaceText =
      "Do you want delete the selected place?";
  static const String delete = "Delete";
  static const String placeDeleted = "Place deleted successfully";
  static const String help = "Help";
  static const String noThanks = "No Thanks";
  static const String txtPromotion =
      "PACER provides walking support widgets and features. Try out our Free & Light weight CAR TRACKER app with driving navigation support.";
  static const String internetNotConnected = "Connect with Internet";
  static const String txtNetOrLocationError =
      "Turn ON your Internet and GPS Location to get figures below";
  static const String promotionalAd = "Promotional Ad";
  static const String clickToInstall = "Click here to install";
  static const String featureNotSupported =
      "Feature not supported with your device";
  static const String language = "Language";
  static const String showingAds = "Showing Ads...";
  static const String sensorInfoDetector = "Dedicated Step Sensor Activated";
  static const String sensorInfoCounter = "Dedicated Step Sensor Activated";
  static const String sensorInfoAccelerometer = "Using Alternate sensors";
  static const String sensorInfoNoSensor = "No step sensor found";
  static const String stepSensor = "Step Sensor";
  static const String details = "Details";
  static const String sensorMessage =
      "PACER uses various device sensors to detect the steps alternatively. Dedicated \"STEP DETECTOR SENSOR\" gives the best performance to detect the steps, but if it is not found in the device, PACER uses \"ALTERNATE SENSORS\" to detect the steps. Steps detection may be inefficient because of the absence of dedicated \"STEP DETECTOR SENSOR\" in the device. To improve performance with \"ALTERNATE SENSORS\", it is recommended to use Pacer with GPS location turned ON. If no sensor is found in the device that can help in the detection of steps, then \"No Step Sensor Found\" message is displayed.";
  static const String trackingMsg = "Recording Track";
  static const String location = "Location";
  static const String locationIsOnMsg = "Location is already turned ON";
  static const String duration = "Duration";
  static const String walkStatus = "Walk Status";
  static const String wsMsg1 =
      "This icon shows the current status of movement as mentioned below:";
  static const String staticPositionDesc =
      "This icon indicates that the device holder is neither walking nor running but in a static mode.";
  static const String walkingDesc =
      "This icon indicates that the walking mode has been activated because PACER has detected device movement in the proper walking rhythm.";
  static const String runningDesc =
      "This icon indicates that the running mode has been activated now because PACER has detected that the device is moving in the proper running rhythm.";
  static const String enableGpsBtnTxt = "Enable Gps to track your walks";
  static const String enableGpsMsg =
      "Turn GPS location ON to let the device sense your current location and save your daily walks.";
  static const String enableGps = "Turn on GPS Location";
  static const String turnOn = "Turn ON";
  static const String noDataAvailable = "No Data Available";
  static const String txtCalories = "Calories";

  // Translations
  static const Map<String, String> de = {
    'appName': 'Schrittmacher',
    'unknown': 'Unbekannt',
    'slogan': 'Sei fit Sei gesund',
    'widgets': 'Widgets',
    'history': 'Geschichte',
    'goal': 'Tor',
    'track': 'Spur',
    'hello_blank_fragment': 'Hallo leeres Fragment',
    'performance': 'Aufführung',
    'distance': 'Entfernung',
    'calories': 'Kalorien',
    'time': 'Zeit',
    'tracking': 'Verfolgung',
    'walking': 'Gehen',
    'steps': 'Schritte',
    'completed': 'abgeschlossen',
    'goalsetting': 'Ziele setzen',
    'goal_cals': 'Kalorien (kcal)',
    'goal_steps': 'Schritte',
    'goal_distance': 'Entfernung (km)',
    'prgress': 'Fortschritt',
    'totalcalsburn': 'Verbrannte Gesamtkalorien',
    'totalstepstaken': 'Insgesamt unternommene Schritte',
    'totaldistancecovered': 'Zurückgelegte Gesamtstrecke',
    'avgcalburned': 'Durchschnittlich verbrannte Kalorien',
    'direction': 'RICHTUNG',
    'speed': 'GESCHWINDIGKEIT',
    'flashlight': 'Blitzlicht',
    'daily': 'Täglich',
    'monthly': 'Monatlich',
    'weekly': 'Wöchentlich',
    'yearly': 'Jährlich',
    'moreapps': 'Mehr Apps',
    'shareapp': 'App teilen',
    'feedback': 'Rückkopplung',
    'likeus': 'mögen uns',
    'privacypolicy': 'Datenschutz-Bestimmungen',
    'website': 'Netz Seite',
    'goalsaved': 'Ziel erfolgreich aktualisiert',
    'NeedPermissions': 'Benötigen Sie Berechtigungen',
    'needspermission':
        'Diese App benötigt die Berechtigung, um diese Funktion zu verwenden. Sie können sie in den App-Einstellungen gewähren.',
    'GOTOSETTINGS': 'GEHE ZU DEN EINSTELLUNGEN',
    'Cancel': 'Stornieren',
    'turnoff': 'Abschalten',
    'suretoturnoff': 'Sind Sie sicher, dass Sie ausschalten möchten?',
    'yes': 'Yes',
    'no': 'Nein',
    'servicestoped': 'Setps zählen als angehalten',
    'servicestarted': 'Schrittmacher verfolgt jetzt Ihre Spaziergänge',
    'today': 'Heute',
    'running': 'Laufen',
    'staticposition': 'Statisch',
    'highspeed': 'Schnelle Geschwindigkeit',
    'recordingtrack': 'Verfolgung',
    'trackingstoped': 'Verfolgung',
    'humidity': 'Feuchtigkeit',
    'sunrise': 'Sonnenaufgang',
    'sunset': 'Sonnenuntergang',
    'Addressnotfound': 'Keine Adresse gefunden',
    'choosemaptype': 'Wählen Sie Kartentyp',
    'terrain': 'Gelände',
    'satelite': 'Satellit',
    'defaultmap': 'Standard',
    'addmyplace': 'Platz hinzufügen',
    'LocationName': 'Standortnamen',
    'LocationAddress': 'Adresse',
    'SelectCategory': 'Kategorie wählen',
    'save': 'speichern',
    'fillfieldtoproceed': 'Bitte füllen Sie dieses Feld aus, um fortzufahren',
    'placeaddedsucessfully': 'Ihr Platz wurde erfolgreich hinzugefügt',
    'letsgo': 'Lass uns gehen',
    'currentweek': 'Diese Woche',
    'erroraqruiringdata': 'Fehler beim Erfassen von Daten',
    'text_share_img_btm':
        'Gehen Sie weiter und bleiben Sie mit Schrittmacher gesund',
    'chooselanguage': 'Sprache wählen',
    'ok': 'okay',
    'gotit': 'Verstanden',
    'welcome': 'Herzlich willkommen',
    'guide_performance':
        'Mit Schrittmacher können Sie alle Fitness-Grundlagen verfolgen, unabhängig davon, ob Sie Ihre Schritte zählen, eine Entfernungsprüfung durchführen, Kalorien verbrennen oder aktive Zeit. Auf diesem Bildschirm können Sie Ihre aktuelle Leistung verfolgen. Hier können Sie auch Aufzeichnungen früherer Tage sehen. Sie können Ihre Leistungsverfolgung mit dem Netzschalter oben rechts auf dem Bildschirm starten / stoppen. Der Kreis links zeigt den Gehstatus an, dass Sie entweder laufen, laufen oder statisch sind. Der Kreis rechts zeigt an, ob Schrittmacher Ihren Spaziergang verfolgt oder nicht. Während Schritte und Zielerreichung in der Mitte angezeigt werden.',
    'guide_goal':
        'Hier können Sie Ihre wöchentliche Fitnessroutine & Tore. Wählen Sie den Tag aus und geben Sie den Wert in eines der Felder ein. Der geschätzte Wert anderer Felder wird automatisch berechnet. Das Zeitplandiagramm wird unten angezeigt und zeigt den Vergleich zwischen den für Wochentage geplanten Zielen.',
    'guide_history':
        'Hier erhalten Sie einen Überblick über Ihre wöchentliche, monatliche oder jährliche Leistung in Form von Grafiken. Sie können Ihre Leistung auch über die Schaltfläche "Teilen" oben rechts auf dem Bildschirm freigeben.',
    'guide_track':
        'Hier sehen Sie die Tracks des aktuellen Datums auf der Karte. Sie können die Karte in der Gelände- und Satellitenansicht anzeigen, indem Sie den Typ ändern. Sie können jeden Ort auch als Ihren Lieblingsort markieren und ihn oder den aktuellen Ort über ein beliebiges Freigabemedium freigeben. Wählen Sie eine Ortsmarkierung auf der Karte aus, um sie freizugeben oder zu löschen.',
    'guide_widgets':
        'Dieser Bildschirm zeigt Adresse, Temperatur, Luftfeuchtigkeit, Sonnenuntergang / Sonnenaufgang und die Richtung Ihres aktuellen Standorts an. Es zeigt auch Ihre aktuelle Geschwindigkeit. Sie können das Blitzlicht Ihres Mobilteils mit der Taste "Blitzlicht" ein- und ausschalten.',
    'delete': 'Löschen',
    'deleteplace': 'Ort löschen',
    'deleteplacetext': 'Möchten Sie den ausgewählten Ort löschen?',
    'placedeleted': 'Platz erfolgreich gelöscht',
    'text_shareloc':
        'Verfolgen Sie die Leistung Ihres Alltags mit PACER: Eine Stepcounter- und Walk-Tracker-Anwendung',
    'help': 'Hilfe',
    'internetnotconnected': 'Verbinden Sie sich mit dem Internet',
    'nothanks': 'Nein Danke',
    'txt_netorlocationerror':
        'Schalten Sie Ihren Internet- und GPS-Standort ein, um die folgenden Zahlen zu erhalten',
    'txt_promotion':
        'PACER bietet Widgets und Funktionen zur Unterstützung des Gehens. Probieren Sie unsere Free & Leichte CAR TRACKER App mit Unterstützung für die Fahrnavigation.',
    'clicktoinstall': 'Klicken Sie hier, um zu installieren',
    'promotioalad': 'Werbeanzeige',
    'featurenotsupported': 'Funktion wird von Ihrem Gerät nicht unterstützt',
    'language': 'Sprache',
    'showingads': 'Anzeigen anzeigen ...',
    'sensorinfo_detector': 'Dedizierter Schrittsensor aktiviert',
    'sensorinfo_counter': 'Dedizierter Schrittsensor aktiviert',
    'sensorinfo_accelerometer': 'Alternative Sensoren verwenden',
    'sensorinfo_nosensor': 'Kein Schrittsensor gefunden',
    'stepsensor': 'Schrittsensor',
    'details': 'Einzelheiten',
    'sensor_message':
        'PACER verwendet alternativ verschiedene Gerätesensoren, um die Schritte zu erfassen. Der dedizierte "STEP DETECTOR SENSOR" bietet die beste Leistung zum Erkennen der Schritte. Wenn er jedoch nicht im Gerät gefunden wird, verwendet PACER "ALTERNATE SENSORS", um die Schritte zu erkennen. Die Erkennung von Schritten kann ineffizient sein, da im Gerät kein dedizierter "STEP DETECTOR SENSOR" vorhanden ist. Um die Leistung mit "ALTERNATE SENSORS" zu verbessern, wird empfohlen, Pacer mit eingeschaltetem GPS-Standort zu verwenden. Wenn im Gerät kein Sensor gefunden wurde, der bei der Erkennung von Schritten helfen kann, wird die Meldung "Kein Schrittsensor gefunden" angezeigt.',
    'trackingmsg': 'Aufnahmespur',
    'location': 'Ort',
    'locationIsOnMsg': 'Der Standort ist bereits eingeschaltet',
    'duration': 'Dauer',
    'walk_status': 'Gehstatus',
    'ws_msg_1':
        'Dieses Symbol zeigt den aktuellen Bewegungsstatus wie folgt an:',
    'staticposition_desc':
        'Dieses Symbol zeigt an, dass der Gerätehalter weder läuft noch läuft, sondern sich im statischen Modus befindet.',
    'walking_desc':
        'Dieses Symbol zeigt an, dass der Gehmodus aktiviert wurde, weil PACER die Gerätebewegung im richtigen Laufrhythmus erkannt hat.',
    'running_desc':
        'Dieses Symbol zeigt an, dass der Betriebsmodus jetzt aktiviert wurde, da PACER festgestellt hat, dass sich das Gerät in einem ordnungsgemäß ausgeführten Rhythmus bewegt.',
  };

  static const Map<String, String> en = {
    'appName': 'Pacer',
    'appNamePacerBelowIcon': 'Pacer',
    'openWeatherMapsAppId': '4c793cb19b60aaba128033617e6c1187',
    'appLink': 'https://bit.ly/31D06BE',
    'admobAppID': 'ca-app-pub-5238824914705486~7105277286',
    'sotwNorth': 'N',
    'sotwEast': 'E',
    'sotwSouth': 'S',
    'sotwWest': 'W',
    'sotwNorthEast': 'NE',
    'sotwNorthWest': 'NW',
    'sotwSouthEast': 'SE',
    'sotwSouthWest': 'SW',
    'weatherSunny': '\u{f00d}',
    'weatherClearNight': '\u{f02e}',
    'weatherFoggy': '\u{f014}',
    'weatherCloudy': '\u{f013}',
    'weatherRainy': '\u{f019}',
    'weatherSnowy': '\u{f01b}',
    'weatherThunder': '\u{f01e}',
    'weatherDrizzle': '\u{f01c}',
    'unknown': 'Unknown',
    'slogan': 'Be Fit, Be Healthy',
    'widgets': 'Widgets',
    'history': 'History',
    'goal': 'Goal',
    'track': 'Track',
    'helloBlankFragment': 'Hello blank fragment',
    'performance': 'Performance',
    'distance': 'Distance',
    'calories': 'Calories',
    'time': 'Time',
    'tracking': 'Tracking',
    'walking': 'Walking',
    'steps': 'Steps',
    'completed': 'completed',
    'goalSetting': 'Goal Setting',
    'goalCals': 'Calories (kcal)',
    'goalSteps': 'Steps',
    'goalDistance': 'Distance (km)',
    'progress': 'Progress',
    'totalcalsburn': 'Total Calories Burnt',
    'totalstepstaken': 'Total Steps Taken',
    'totaldistancecovered': 'Total Distance Covered',
    'avgcalburned': 'Average Calories Burnt',
    'direction': 'DIRECTION',
    'speed': 'SPEED',
    'flashlight': 'Flash Light',
    'daily': 'Daily',
    'monthly': 'Monthly',
    'weekly': 'Weekly',
    'yearly': 'Yearly',
    'moreApps': 'More Apps',
    'shareApp': 'Share App',
    'feedback': 'Feedback',
    'likeUs': 'Rate us',
    'privacyPolicy': 'Privacy Policy',
    'website': 'Website',
    'privacyText':
        'Charisma Apps (CA) provides Free Tools, Educational and Entertainment material mostly in the form of Apps for mobile devices. CA respects the privacy of the users of all its Applications especially their personal information such as contacts, photos, videos, textual messages or other saved contents throughout the lifetime of App usage.\n\nAccording any information collected, processed, saved or transmitted within the declared scope of the functions published in the App is done strictly with the approval, consent of the users. Most of the times, such events are initiated by the user himself/herself on every instance.\n\nWhile CA makes its best effort to safeguard the personal information mentioned above while stored on the device or in use by the App within its defined/declared scope, CA will not be responsible for any loss of information or data or any consequential loss/damage thereof due to any reason including malfunction of the host device or other malicious code or Apps running on it.\n\nFor more details visit our',
    'privacyUrl': 'http://charismaapps.co/privacy%20policy.html',
    'email': 'charismaapps@gmail.com',
    'goalSaved': 'Goal updated successfully',
    'needPermissions': 'Need Permissions',
    'needsPermission':
        'This app needs permission to use this feature. You can grant them in app settings.',
    'GOTOSETTINGS': 'GOTO SETTINGS',
    'cancel': 'Cancel',
    'turnOff': 'Turn Off',
    'sureToTurnOff': 'Are you sure you want to Turn OFF Tracking?',
    'yes': 'Yes',
    'no': 'No',
    'serviceStopped': 'Steps Counting has been Paused',
    'serviceStarted': 'Pacer is tracking your walks now',
    'today': 'Today',
    'running': 'Running',
    'staticPosition': 'Static',
    'highSpeed': 'High Speed',
    'recordingTrack': 'Tracking',
    'trackingstoped': 'Tracking',
    'humidity': 'Humidity',
    'sunrise': 'Sunrise',
    'sunset': 'Sunset',
    'addressNotFound': 'No Address Found',
    'chooseMapType': 'Choose Map Type',
    'terrain': 'Terrain',
    'satellite': 'Satellite',
    'defaultMap': 'Default',
    'addMyPlace': 'Add Place',
    'locationName': 'Location Name',
    'LocationAddress': 'Address',
    'selectCategory': 'Select Category',
    'save': 'Save',
    'fillFieldToProceed': 'Please fill out this field to proceed',
    'placeAddedSuccessfully': 'Your place has been successfully added',
    'letsgo': "Let's Go",
    'currentWeek': 'Current Week',
    'errorAcquiringData': 'Error Acquiring Data',
    'textShareImgBtm': 'Keep walking and stay healthy with PACER',
    'chooseLanguage': 'Choose Language',
    'ok': 'Ok',
    'gotIt': 'Got it',
    'welcome': 'Welcome',
    'guidePerformance':
        'PACER allows you to track all the fitness basics whether it\'s counting your steps, maintain a distance check, burned calories or active time. You can follow your current performance on this screen. Also you can see records of previous days here. You can start/stop your performance tracking using the power button on top right of the screen. The circle on left shows the walking status that either you are walking, running or static. Circle on right shows either PACER is tracking your walk or not. While steps taken and goal achievement is shown in the middle one.',
    'guideGoal':
        'Here you can schedule and set your weekly fitness routine & Goals. Select the day and enter the value in any of the fields it will auto calculate the estimated value of other fields. Schedule chart is shown at the bottom that shows comparison between the goals scheduled for days of the week',
    'guideHistory':
        'Here you can get an overview of your weekly, monthly or yearly performance in the form of graphs. You can also share you performance by using share button at top right of the screen.',
    'guideTrack':
        'Here you can see the tracks recorded of current date on map. You can view map in Terrain and Satellite view by changing its type. You can also mark any place as your favorite place and share it or current location via any sharing media. Select place marker on map to share or delete it.',
    'guideWidgets':
        'This screen shows address, temperature, humidity, sunset/sunrise timings and direction of your current location. It also shows your current speed. You can turn ON/OFF flash light of your handset using "Flash Light" button',
    'textShareLoc':
        'Track your everyday\'s performance with PACER: A step counter and walk tracker Application',
    'deletePlace': 'Delete Place',
    'deletePlaceText': 'Do you want delete the selected place?',
    'delete': 'Delete',
    'placeDeleted': 'Place deleted successfully',
    'help': 'Help',
    'noThanks': 'No Thanks',
    'txtPromotion':
        'PACER provides walking support widgets and features. Try out our Free & Light weight CAR TRACKER app with driving navigation support.',
    'internetNotConnected': 'Connect with Internet',
    'txtNetOrLocationError':
        'Turn ON your Internet and GPS Location to get figures below',
    'promotionalAd': 'Promotional Ad',
    'clickToInstall': 'Click here to install',
    'featureNotSupported': 'Feature not supported with your device',
    'language': 'Language',
    'showingAds': 'Showing Ads...',
    'sensorInfoDetector': 'Dedicated Step Sensor Activated',
    'sensorInfoCounter': 'Dedicated Step Sensor Activated',
    'sensorInfoAccelerometer': 'Using Alternate sensors',
    'sensorInfoNoSensor': 'No step sensor found',
    'stepSensor': 'Step Sensor',
    'details': 'Details',
    'sensorMessage':
        'PACER uses various device sensors to detect the steps alternatively. Dedicated "STEP DETECTOR SENSOR" gives the best performance to detect the steps, but if it is not found in the device, PACER uses "ALTERNATE SENSORS" to detect the steps. Steps detection may be inefficient because of the absence of dedicated "STEP DETECTOR SENSOR" in the device. To improve performance with "ALTERNATE SENSORS", it is recommended to use Pacer with GPS location turned ON. If no sensor is found in the device that can help in the detection of steps, then "No Step Sensor Found" message is displayed.',
    'trackingMsg': 'Recording Track',
    'location': 'Location',
    'locationIsOnMsg': 'Location is already turned ON',
    'duration': 'Duration',
    'walkStatus': 'Walk Status',
    'wsMsg1':
        'This icon shows the current status of movement as mentioned below:',
    'staticPositionDesc':
        'This icon indicates that the device holder is neither walking nor running but in a static mode.',
    'walkingDesc':
        'This icon indicates that the walking mode has been activated because PACER has detected device movement in the proper walking rhythm.',
    'runningDesc':
        'This icon indicates that the running mode has been activated now because PACER has detected that the device is moving in the proper running rhythm.',
    'enableGpsBtnTxt': 'Enable Gps to track your walks',
    'enableGpsMsg':
        'Turn GPS location ON to let the device sense your current location and save your daily walks.',
    'enableGps': 'Turn on GPS Location',
    'turnOn': 'Turn ON',
    'noDataAvailable': 'No Data Available',
    'txtCalories': 'Calories',
  };

  static const Map<String, String> pt = {
    'appName': 'Pacer',
    'LocationAddress': 'Endereço',
    'addmyplace': 'Adicionar local',
    'GOTOSETTINGS': 'VÁ PARA AS CONFIGURAÇÕES',
    'letsgo': 'Vamos lá',
    'yearly': 'Anual',
    'Cancel': 'Cancelar',
    'Addressnotfound': 'Nenhum endereço encontrado',
    'today': 'Hoje',
    'NeedPermissions': 'Precisa de permissões',
    'welcome': 'Bem-vinda',
    'hello_blank_fragment': 'Olá fragmento em branco',
    'calories': 'Calorias',
    'goal_cals': 'Calorias (kcal)',
    'avgcalburned': 'Calorias médias queimadas',
    'guide_widgets':
        'Essa tela mostra o endereço, temperatura, umidade, horários do pôr-do-sol e nascer do sol e a direção da sua localização atual. Também mostra sua velocidade atual. Você pode ligar / desligar a luz do flash do seu telefone usando o botão Flash Light',
    'needspermission':
        'Este aplicativo precisa de permissão para usar esse recurso. Você pode concedê-los nas configurações do aplicativo.',
    'currentweek': 'Semana atual',
    'SelectCategory': 'Selecione a Categoria',
    'chooselanguage': 'Escolha o seu idioma',
    'choosemaptype': 'Escolha o tipo de mapa',
    'likeus': 'Como nós',
    'text_share_img_btm': 'Continue andando e mantenha-se saudável com o PACER',
    'ok': 'Está bem',
    'defaultmap': 'Padrão',
    'goalsetting': 'Estabelecimento de Metas',
    'direction': 'DIREÇÃO',
    'distance': 'Distância',
    'goal_distance': 'Distância (km)',
    'totaldistancecovered': 'Distância total percorrida',
    'daily': 'Diariamente',
    'walking': 'Caminhada',
    'save': 'Salve',
    'erroraqruiringdata': 'Erro ao adquirir dados',
    'turnoff': 'Desligar',
    'suretoturnoff': 'Tem certeza de que deseja desativar o rastreamento?',
    'flashlight': 'Flash Light',
    'running': 'Corrida',
    'highspeed': 'Alta velocidade',
    'weekly': 'Semanal',
    'history': 'História',
    'humidity': 'Umidade',
    'guide_history':
        'Aqui você pode obter uma visão geral do seu desempenho semanal, mensal ou anual na forma de gráficos. Você também pode compartilhar seu desempenho usando o botão de compartilhamento no canto superior direito da tela.',
    'guide_goal':
        'Aqui você pode agendar e definir sua rotina semanal de condicionamento físico & Metas. Selecione o dia e insira o valor em qualquer um dos campos que calculará automaticamente o valor estimado de outros campos. O gráfico de agendamento é mostrado na parte inferior que mostra a comparação entre as metas programadas para os dias da semana',
    'guide_track':
        'Aqui você pode ver as faixas gravadas da data atual no mapa. Você pode visualizar o mapa na visualização Terreno e Satélite, alterando seu tipo. Você também pode marcar qualquer lugar como seu lugar favorito e compartilhá-lo ou local atual através de qualquer mídia de compartilhamento. Selecione o marcador de local no mapa para compartilhá-lo ou excluí-lo.',
    'unknown': 'Desconhecido',
    'gotit': 'Entendi',
    'speed': 'RAPIDEZ',
    'sunset': 'Pôr do sol',
    'prgress': 'Progresso',
    'sunrise': 'Nascer do sol',
    'placedeleted': 'Local excluído com sucesso',
    'monthly': 'Por mês',
    'LocationName': 'Nome do local',
    'no': 'Não',
    'goal': 'Objetivo',
    'goalsaved': 'Objetivo atualizado com sucesso',
    'yes': 'sim',
    'servicestarted': 'O Pacer está rastreando suas caminhadas agora',
    'guide_performance':
        'O PACER permite que você acompanhe todos os conceitos básicos de condicionamento físico, contando seus passos, mantendo uma verificação de distância, queimando calorias ou tempo ativo. Você pode acompanhar o seu desempenho atual nesta tela. Além disso, você pode ver os registros dos dias anteriores aqui. Você pode iniciar / parar o rastreamento de desempenho usando o botão liga / desliga no canto superior direito da tela. O círculo à esquerda mostra o status de caminhada que você está andando, correndo ou estático. O círculo à direita mostra que o PACER está rastreando sua caminhada ou não. Enquanto os passos dados e a realização dos objetivos são mostrados no meio.',
    'shareapp': 'Compartilhe o aplicativo',
    'goal_steps': 'Passos',
    'steps': 'Passos',
    'completed': 'concluído',
    'delete': 'Delete',
    'deleteplace': 'Excluir local',
    'deleteplacetext': 'Deseja excluir o local selecionado?',
    'feedback': 'Comentários',
    'fillfieldtoproceed': 'Por favor, preencha este campo para continuar',
    'moreapps': 'Mais aplicativos',
    'performance': 'atuação',
    'placeaddedsucessfully': 'Seu lugar foi adicionado com sucesso',
    'privacypolicy': 'Política de Privacidade',
    'recordingtrack': 'Rastreamento',
    'satelite': 'Satélite',
    'servicestoped': 'Contagens de conjuntos como pausados',
    'slogan': 'Seja em forma Seja saudável',
    'staticposition': 'Estático',
    'terrain': 'Terreno',
    'text_shareloc':
        'Acompanhe o desempenho do seu dia a dia com o PACER: um aplicativo de contador de passos e rastreador de caminhada',
    'time': 'Tempo',
    'totalcalsburn': 'Total de calorias queimadas',
    'totalstepstaken': 'Total de etapas executadas',
    'track': 'Track',
    'tracking': 'Rastreamento',
    'trackingstoped': 'Rastreamento',
    'website': 'Local na rede Internet',
    'widgets': 'Widgets',
    'help': 'Socorro',
    'internetnotconnected': 'Conecte-se à Internet',
    'nothanks': 'Não, obrigado',
    'txt_netorlocationerror':
        'Ligue a Internet e a localização GPS para obter os números abaixo',
    'txt_promotion':
        'O PACER fornece widgets e recursos de suporte a pé. Experimente o nosso Free & Aplicativo leve do CAR TRACKER com suporte à navegação de direção.',
    'clicktoinstall': 'Clique aqui para instalar',
    'promotioalad': 'Anúncio promocional',
    'featurenotsupported': 'Recurso não suportado pelo seu dispositivo',
    'language': 'Língua',
    'showingads': 'Mostrando anúncios ...',
    'sensorinfo_detector': 'Sensor de passo dedicado ativado',
    'sensorinfo_counter': 'Sensor de passo dedicado ativado',
    'sensorinfo_accelerometer': 'Usando sensores alternativos',
    'sensorinfo_nosensor': 'Nenhum sensor de passo encontrado',
    'stepsensor': 'Sensor de passo',
    'details': 'Detalhes',
    'sensor_message':
        'O PACER usa vários sensores de dispositivo para detectar as etapas alternativamente. O "SENSOR DE DETECTOR DE PASSOS" dedicado oferece o melhor desempenho para detectar os passos, mas se não for encontrado no dispositivo, o PACER usa "SENSORES ALTERNATIVOS" para detectar os passos. A detecção de etapas pode ser ineficiente devido à ausência de um "SENSOR DE DETECTOR DE PASSOS" dedicado no dispositivo. Para melhorar o desempenho com "SENSORES ALTERNATIVOS", é recomendado usar o Pacer com a localização GPS LIGADA. Se nenhum sensor for encontrado no dispositivo que possa ajudar na detecção de etapas, a mensagem "Nenhum sensor de etapa encontrado" será exibida.',
    'trackingmsg': 'Faixa de Gravação',
    'location': 'Localização',
    'locationIsOnMsg': 'A localização já está ATIVADA',
    'duration': 'Duração',
    'walk_status': 'Status de caminhada',
    'ws_msg_1':
        'Este ícone mostra o status atual do movimento, conforme mencionado abaixo:',
    'staticposition_desc':
        'Este ícone indica que o suporte do dispositivo não está andando nem correndo, mas no modo estático.',
    'walking_desc':
        'Este ícone indica que o modo de caminhada foi ativado porque o PACER detectou movimento do dispositivo no ritmo adequado para caminhar.',
    'running_desc':
        'Este ícone indica que o modo de execução foi ativado agora porque o PACER detectou que o dispositivo está se movendo no ritmo de execução adequado.',
  };

  static const Map<String, String> hi = {
    'appName': 'पेसर',
    'LocationAddress': 'पता',
    'addmyplace': 'स्थान जोड़ें',
    'GOTOSETTINGS': 'सेटिंग्स में जाएं',
    'letsgo': 'चलो चलते हैं',
    'yearly': 'वार्षिक',
    'Cancel': 'रद्द करें',
    'Addressnotfound': 'पता नहीं मिला',
    'today': 'आज',
    'NeedPermissions': 'अनुमतियाँ आवश्यक',
    'welcome': 'स्वागत हे',
    'hello_blank_fragment': 'नमस्ते खाली टुकड़ा',
    'calories': 'कैलोरी',
    'goal_cals': 'कैलोरी (कैलो)',
    'avgcalburned': 'औसत जलाए गए कैलोरी',
    'guide_widgets':
        'यह स्क्रीन आपके वर्तमान स्थान का पता, तापमान, आर्द्रता, सूर्यास्त और सूर्योदय का समय और आपकी वर्तमान गति दिखाती है। आप अपने फोन के फ्लैश लाइट बटन का उपयोग करके फ्लैश लाइट को चालू / बंद कर सकते हैं।',
    'needspermission':
        'इस ऐप को इस सुविधा का उपयोग करने के लिए अनुमति की आवश्यकता होती है। आप ऐप की सेटिंग्स में उन्हें प्रदान कर सकते हैं।',
    'currentweek': 'वर्तमान सप्ताह',
    'SelectCategory': 'श्रेणी का चयन करें',
    'chooselanguage': 'अपनी भाषा चुनें',
    'choosemaptype': 'मानचित्र के प्रकार का चयन करें',
    'likeus': 'हमें पसंद करें',
    'text_share_img_btm': 'पेसर के साथ चलते रहें और स्वस्थ रहें',
    'ok': 'ठीक है',
    'defaultmap': 'डिफ़ॉल्ट',
    'goalsetting': 'लक्ष्य सेटिंग',
    'direction': 'दिशा',
    'distance': 'दूरी',
    'goal_distance': 'दूरी (किमी)',
    'totaldistancecovered': 'कुल दूरी कवर की गई',
    'daily': 'दैनिक',
    'walking': 'चलना',
    'save': 'सहेजें',
    'erroraqruiringdata': 'डेटा प्राप्त करने में त्रुटि',
    'turnoff': 'बंद कर दो',
    'suretoturnoff': 'क्या आप प्रयास करना बंद करना चाहते हैं?',
    'flashlight': 'फ्लैश लाइट',
    'running': 'दौड़',
    'highspeed': 'उच्च गति',
    'weekly': 'साप्ताहिक',
    'history': 'इतिहास',
    'humidity': 'नमी',
    'guide_history':
        'यहां आप चार्ट के रूप में साप्ताहिक, मासिक या वार्षिक प्रदर्शन का एक सारांश प्राप्त कर सकते हैं। आप शीर्ष दाईं ओर के शेयर बटन का उपयोग करके अपने प्रदर्शन को साझा कर सकते हैं।',
    'guide_goal':
        'यहां आप अपने साप्ताहिक व्यायाम और लक्ष्यों की योजना कर सकते हैं। दिन का चयन करें और किसी भी क्षेत्र में मान दर्ज करें और यह स्वचालित रूप से अन्य क्षेत्रों के अनुमानित मान की गणना करेगा। नीचे दिखाई देने वाला ग्राफ़ वर्कआउट चार्ट है जो सप्ताह के दिनों के लिए निर्धारित लक्ष्यों के बीच तुलना दिखाता है।',
    'guide_track':
        'यहां आप मानचित्र पर वर्तमान तारिक़ के रिकॉर्ड को देख सकते हैं। आप मानचित्र को भूमि और उपग्रह दृश्य में देख सकते हैं, इसके प्रकार को बदलकर। आप किसी भी स्थान को अपने पसंदीदा स्थान के रूप में चिह्नित कर सकते हैं और उसे साझा कर सकते हैं या किसी भी साझा करने वाले माध्यम के माध्यम से वर्तमान स्थान। साझा करने या हटाने के लिए मानचित्र पर स्थान चिह्नित करें।',
    'unknown': 'अज्ञात',
    'gotit': 'समझा',
    'speed': 'गति',
    'sunset': 'सूर्यास्त',
    'prgress': 'प्रगति',
    'sunrise': 'सूर्योदय',
    'placedeleted': 'स्थान सफलतापूर्वक हटा दिया गया',
    'monthly': 'मासिक',
    'LocationName': 'स्थान का नाम',
    'no': 'नहीं',
    'goal': 'लक्ष्य',
    'goalsaved': 'लक्ष्य सफलतापूर्वक अपडेट किया गया',
    'yes': 'हाँ',
    'servicestarted': 'पेसर अब आपकी पैदल चलने की गति का निरीक्षण कर रहा है',
    'guide_performance':
        'पेसर आपको शारीरिक फिटनेस के सभी मूल अवधारणाओं का पता लगाने में मदद करता है, चरणों की गिनती करके, दूरी की जांच रखकर, कैलोरी जलाकर या सक्रिय समय रखकर। आप इस स्क्रीन पर अपने वर्तमान प्रदर्शन का निरीक्षण कर सकते हैं। इसके अलावा, आप पिछले दिनों के रिकॉर्ड भी यहां देख सकते हैं। आप शीर्ष दाईं ओर के पावर बटन का उपयोग करके प्रदर्शन निरीक्षण का सक्रिय / निष्क्रिय कर सकते हैं। बाईं ओर का वृत्त दिखाता है कि आप किस चरण पर चल रहे हैं, चल रहे हैं या स्थिर हैं। दाएं ओर का वृत्त दिखाता है कि पेसर आपकी पैदल चलने की गति का निरीक्षण कर रहा है या नहीं। जबकि बीच में दिए गए हैंडसेट और लक्ष्य स्थापित करने की साधारिता दिखाते हैं।',
    'shareapp': 'ऐप साझा करें',
    'goal_steps': 'कदम',
    'steps': 'कदम',
    'completed': 'पूरा हुआ',
    'delete': 'हटाएं',
    'deleteplace': 'स्थान हटाएं',
    'deleteplacetext': 'क्या आप चयनित स्थान को हटाना चाहते हैं?',
    'feedback': 'प्रतिक्रिया',
    'fillfieldtoproceed': 'कृपया इस क्षेत्र को भरें जारी रखने के लिए',
    'moreapps': 'अधिक ऐप्स',
    'performance': 'प्रदर्शन',
    'placeaddedsucessfully': 'आपका स्थान सफलतापूर्वक जोड़ दिया गया है',
    'privacypolicy': 'गोपनीयता नीति',
    'recordingtrack': 'रेकॉर्डिंग ट्रैक',
    'satelite': 'उपग्रह',
    'servicestoped': 'रखरखाव करने की गिनती के रूप में प्रतिष्ठित करें',
    'slogan': 'फिट रहें स्वस्थ रहें',
    'staticposition': 'शांत',
    'terrain': 'भू-रेखा',
    'text_shareloc':
        'पेसर के साथ अपने दैनिक प्रदर्शन का निरीक्षण करें: एक कदम गिनने और पैदल चलने के ट्रैकर ऐप',
    'time': 'समय',
    'totalcalsburn': 'कुल कैलोरी जला दी गई',
    'totalstepstaken': 'कुल कदम चलाए गए',
    'track': 'ट्रैक',
    'tracking': 'ट्रैकिंग',
    'trackingstoped': 'ट्रैकिंग रोकी गई',
    'website': 'वेबसाइट',
    'widgets': 'विजेट्स',
    'help': 'मदद',
    'internetnotconnected': 'इंटरनेट से कनेक्ट नहीं है',
    'nothanks': 'नहीं, धन्यवाद',
    'txt_netorlocationerror':
        'नीचे दिए गए नंबर प्राप्त करने के लिए इंटरनेट और स्थानीय जीपीएस कनेक्शन को चालू करें',
    'txt_promotion':
        'पेसर मुफ्त और हल्के वजन वाले CAR TRACKER ऐप के साथ चलने और दिशा-निर्देश समर्थन के सुविधाओं को प्रदान करता है।',
    'clicktoinstall': 'स्थापित करने के लिए यहाँ क्लिक करें',
    'promotioalad': 'प्रचारित विज्ञापन',
    'featurenotsupported': 'आपके उपकरण द्वारा समर्थित नहीं है',
    'language': 'भाषा',
    'showingads': 'विज्ञापन दिखा रहा है ...',
    'sensorinfo_detector': 'स्टेप डिटेक्टर सेंसर सक्रिय है',
    'sensorinfo_counter': 'स्टेप डिटेक्टर सेंसर सक्रिय है',
    'sensorinfo_accelerometer': 'वैकल्पिक सेंसर का उपयोग करना',
    'sensorinfo_nosensor': 'कोई स्टेप सेंसर नहीं मिला',
    'stepsensor': 'स्टेप सेंसर',
    'details': 'विवरण',
    'sensor_message':
        'पेसर विभिन्न डिवाइस सेंसर्स का उपयोग करता है एक दूसरे के बजाय चरणों का पता लगाने के लिए। "स्टेप डिटेक्टर सेंसर" विशेष सेंसर से पूर्ण होने पर यह सर्वश्रेष्ठ प्रदर्शन प्रदान करता है, लेकिन यदि डिवाइस में नहीं मिलता है, तो पेसर "वैकल्पिक सेंसर्स" का उपयोग करता है चरणों का पता लगाने के लिए। चरण संख्या का पता लगाना असंगत हो सकता है चरण डिटेक्टर सेंसर की अनुपस्थिति के कारण। "वैकल्पिक सेंसर्स" के साथ प्रदर्शन को बेहतर बनाने के लिए, GPS स्थान सक्षम होने की सिफारिश की जाती है। यदि डिवाइस में चरण का पता लगाने के लिए कोई सेंसर नहीं है, तो "कोई स्टेप सेंसर नहीं मिला" संदेश दिखाया जाएगा।',
    'trackingmsg': 'ट्रैक रिकॉर्डिंग',
    'location': 'स्थान',
    'locationIsOnMsg': 'स्थान पहले से ही सक्रिय है',
    'duration': 'अवधि',
    'walk_status': 'चलने की स्थिति',
    'ws_msg_1':
        'यह प्रतीक वर्तमान गति की स्थिति दर्शाता है, जैसा कि नीचे उल्लेख किया गया है:',
    'staticposition_desc':
        'यह प्रतीक दर्शाता है कि उपकरण स्थिर है, न तो चल रहा है और न ही दौड़ रहा है।',
    'walking_desc':
        'यह प्रतीक दर्शाता है कि चलने की स्थिति सक्रिय है क्योंकि पेसर ने उपकरण की चाल को चलने के लिए उपयुक्त गति में पहचाना है।',
    'running_desc':
        'यह प्रतीक दर्शाता है कि दौड़ की स्थिति अब सक्रिय हो गई है क्योंकि पेसर ने उपकरण को दौड़ने के लिए उचित गति में चल रहा है।',
  };

  static const Map<String, String> fr = {
    'appName': 'Meneur de train',
    'unknown': 'inconnue',
    'slogan': 'Soyez en forme Soyez en bonne santé',
    'widgets': 'Widgets',
    'history': 'Histoire',
    'goal': 'Objectif',
    'track': 'Piste',
    'hello_blank_fragment': 'Bonjour fragment vierge',
    'performance': 'Performance',
    'distance': 'Distance',
    'calories': 'Calories',
    'time': 'Temps',
    'tracking': 'Suivie',
    'walking': 'En marchant',
    'steps': 'Pas',
    'completed': 'terminé',
    'goalsetting': 'Définition d\'objectifs',
    'goal_cals': 'Calories (kcal)',
    'goal_steps': 'Pas',
    'goal_distance': 'Distance (km)',
    'prgress': 'Le progrès',
    'totalcalsburn': 'Total des calories brûlées',
    'totalstepstaken': 'Total des mesures prises',
    'totaldistancecovered': 'Distance totale couverte',
    'avgcalburned': 'Calories moyennes brûlées',
    'direction': 'DIRECTION',
    'speed': 'LA VITESSE',
    'flashlight': 'Flash Light',
    'daily': 'du quotidien',
    'monthly': 'Mensuelle',
    'weekly': 'Hebdomadaire',
    'yearly': 'Annuelle',
    'moreapps': 'Plus d\'applications',
    'shareapp': 'Partagez l\'application',
    'feedback': 'Retour d\'information',
    'likeus': 'Comme nous',
    'privacypolicy': 'politique de confidentialité',
    'website': 'Site Internet',
    'goalsaved': 'Objectif mis à jour avec succès',
    'NeedPermissions': 'Besoin d\'autorisations',
    'needspermission':
        'Cette application doit être autorisée à utiliser cette fonctionnalité. Vous pouvez les régler dans les paramètres de l\'application.',
    'GOTOSETTINGS': 'ALLER AUX PARAMÈTRES',
    'Cancel': 'Annuler',
    'turnoff': 'Éteindre',
    'suretoturnoff': 'Êtes-vous sûr de vouloir désactiver?',
    'yes': 'Oui',
    'no': 'Non',
    'servicestoped': 'Setps comptant comme étant en pause',
    'servicestarted': 'Pacer suit maintenant vos promenades',
    'today': 'Aujourd\'hui',
    'running': 'Fonctionnement',
    'staticposition': 'Statique',
    'highspeed': 'Haute vitesse',
    'recordingtrack': 'Suivie',
    'trackingstoped': 'Suivie',
    'humidity': 'Humidité',
    'sunrise': 'lever du soleil',
    'sunset': 'Le coucher du soleil',
    'Addressnotfound': 'Aucune adresse trouvée',
    'choosemaptype': 'Choisissez le type de carte',
    'terrain': 'Terrain',
    'satelite': 'Settelite',
    'defaultmap': 'Défaut',
    'addmyplace': 'Ajouter un lieu',
    'LocationName': 'Nom de la localisation',
    'LocationAddress': 'Adresse',
    'SelectCategory': 'Choisir une catégorie',
    'save': 'enregistrer',
    'fillfieldtoproceed': 'Veuillez remplir ce champ pour continuer',
    'placeaddedsucessfully': 'Votre lieu a été ajouté avec succès',
    'letsgo': 'Allons-y',
    'currentweek': 'Cette semaine',
    'erroraqruiringdata': 'Erreur lors de l\'acquisition des données',
    'text_share_img_btm':
        'Continuez à marcher et à rester en bonne santé avec PACER',
    'chooselanguage': 'Choisissez la langue',
    'ok': 'D\'accord',
    'gotit': 'Je l\'ai',
    'welcome': 'Bienvenue',
    'guide_performance':
        'PACER vous permet de suivre toutes les bases de la remise en forme, qu\'il s\'agisse de compter vos pas, de maintenir une vérification de la distance, des calories brûlées ou du temps d\'activité. Vous pouvez suivre vos performances actuelles sur cet écran. Vous pouvez également voir les enregistrements des jours précédents ici. Vous pouvez démarrer / arrêter votre suivi des performances à l\'aide du bouton d\'alimentation en haut à droite de l\'écran. Le cercle à gauche montre l\'état de marche que vous marchez, courez ou que vous soyez statique. Le cercle à droite indique que PACER suit votre marche ou non. Alors que les étapes franchies et la réalisation des objectifs sont indiqués au milieu.',
    'guide_goal':
        'Ici, vous pouvez planifier et définir votre programme de remise en forme hebdomadaire & Buts. Sélectionnez le jour et entrez la valeur dans l\'un des champs, il calculera automatiquement la valeur estimée des autres champs. Le graphique du calendrier est affiché en bas qui montre la comparaison entre les objectifs prévus pour les jours de la semaine',
    'guide_history':
        'Ici, vous pouvez obtenir un aperçu de vos performances hebdomadaires, mensuelles ou annuelles sous forme de graphiques. Vous pouvez également partager vos performances en utilisant le bouton Partager en haut à droite de l\'écran.',
    'guide_track':
        'Ici, vous pouvez voir les traces enregistrées de la date actuelle sur la carte. Vous pouvez afficher la carte en mode Terrain et Satellite en modifiant son type. Vous pouvez également marquer n\'importe quel endroit comme votre endroit préféré et le partager ou l\'emplacement actuel via n\'importe quel support de partage. Sélectionnez un marqueur de position sur la carte pour le partager ou le supprimer.',
    'guide_widgets':
        'Cet écran affiche l\'adresse, la température, l\'humidité, les heures de coucher / lever de soleil et la direction de votre emplacement actuel. Il montre également votre vitesse actuelle. Vous pouvez allumer / éteindre la lumière du flash de votre combiné à l\'aide du bouton "Flash Light"',
    'text_shareloc':
        'Suivez les performances de votre quotidien avec PACER: une application de compteur de pas et de suivi de marche',
    'placedeleted': 'Lieu supprimé avec succès',
    'deleteplacetext': 'Voulez-vous supprimer le lieu sélectionné?',
    'deleteplace': 'Supprimer le lieu',
    'delete': 'Supprimer',
    'help': 'Aidez-moi',
    'internetnotconnected': 'Connectez-vous avec Internet',
    'nothanks': 'Non merci',
    'txt_netorlocationerror':
        'Allumez votre emplacement Internet et GPS pour obtenir les chiffres ci-dessous',
    'txt_promotion':
        'PACER fournit des widgets et des fonctionnalités d\'assistance à la marche. Essayez notre gratuit & Application CAR TRACKER légère avec prise en charge de la navigation.',
    'clicktoinstall': 'Cliquez ici pour installer',
    'promotioalad': 'Annonce promotionnelle',
    'featurenotsupported': 'Fonction non prise en charge avec votre appareil',
    'language': 'Langue',
    'showingads': 'Affichage des annonces ...',
    'sensorinfo_detector': 'Capteur de pas dédié activé',
    'sensorinfo_counter': 'Capteur de pas dédié activé',
    'sensorinfo_accelerometer': 'Utilisation de capteurs alternatifs',
    'sensorinfo_nosensor': 'Aucun capteur de pas trouvé',
    'stepsensor': 'Capteur de pas',
    'details': 'Détails',
    'sensor_message':
        'PACER utilise divers capteurs d\'appareils pour détecter les étapes en alternance. Le «CAPTEUR DE DÉTECTEUR DE PAS» dédié donne les meilleures performances pour détecter les pas, mais s\'il n\'est pas trouvé dans l\'appareil, PACER utilise des «CAPTEURS ALTERNATIFS» pour détecter les pas. La détection des étapes peut être inefficace en raison de l\'absence de «CAPTEUR DE DÉTECTEUR DE PAS» dédié dans l\'appareil. Pour améliorer les performances avec les «CAPTEURS ALTERNATIFS», il est recommandé d\'utiliser le Pacer avec la localisation GPS activée. Si aucun capteur détecté dans l\'appareil peut aider à la détection des étapes, le message «Aucun capteur d\'étape trouvé» s\'affiche.',
    'trackingmsg': 'Piste d\'enregistrement',
    'location': 'Emplacement',
    'locationIsOnMsg': 'La localisation est déjà activée',
    'duration': 'Durée',
    'walk_status': 'Statut de marche',
    'running_desc':
        'Cette icône indique que le mode de fonctionnement a été activé maintenant parce que PACER a détecté que l\'appareil se déplace au bon rythme de fonctionnement.',
    'walking_desc':
        'Cette icône indique que le mode marche a été activé parce que PACER a détecté un mouvement de l\'appareil au rythme de marche approprié.',
    'staticposition_desc':
        'Cette icône indique que le support de l\'appareil ne marche ni ne court mais en mode statique.',
    'ws_msg_1':
        'Cette icône montre l\'état actuel du mouvement comme mentionné ci-dessous:',
  };

  static const Map<String, String> es = {
    'appName': 'Pacer',
    'Addressnotfound': 'No se encontró dirección',
    'Cancel': 'Cancelar',
    'GOTOSETTINGS': 'IR A LA CONFIGURACIÓN',
    'humidity': 'Humedad',
    'LocationAddress': 'Habla a',
    'LocationName': 'Nombre del lugar',
    'NeedPermissions': 'Necesita permisos',
    'SelectCategory': 'selecciona una categoría',
    'sunrise': 'amanecer',
    'sunset': 'Puesta de sol',
    'addmyplace': 'Añadir lugar',
    'avgcalburned': 'Calorías promedio quemadas',
    'calories': 'Calorías',
    'chooselanguage': 'Elige lengua',
    'choosemaptype': 'Elegir tipo de mapa',
    'completed': 'terminado',
    'currentweek': 'semana actual',
    'daily': 'Diario',
    'defaultmap': 'Defecto',
    'delete': 'Eliminar',
    'deleteplace': 'Eliminar lugar',
    'deleteplacetext': '¿Quieres eliminar el lugar seleccionado?',
    'direction': 'DIRECCIÓN',
    'distance': 'Distancia',
    'erroraqruiringdata': 'Error al adquirir datos',
    'feedback': 'Retroalimentación',
    'fillfieldtoproceed': 'Por favor complete este campo para continuar',
    'flashlight': 'Linterna',
    'goal': 'Objetivo',
    'goal_cals': 'Calorías (kcal)',
    'goal_distance': 'Distancia (km)',
    'goal_steps': 'Pasos',
    'goalsaved': 'Objetivo actualizado correctamente',
    'goalsetting': 'El establecimiento de metas',
    'gotit': 'Entendido',
    'guide_goal':
        'Aquí puede programar y establecer su rutina de ejercicios semanal & Metas. Seleccione el día e ingrese el valor en cualquiera de los campos, calculará automáticamente el valor estimado de otros campos. La tabla de programación se muestra en la parte inferior que muestra la comparación entre las metas programadas para los días de la semana.',
    'guide_history':
        'Aquí puede obtener una visión general de su rendimiento semanal, mensual o anual en forma de gráficos. También puede compartir su rendimiento utilizando el botón Compartir en la parte superior derecha de la pantalla.',
    'guide_performance':
        'PACER le permite realizar un seguimiento de todos los aspectos básicos del estado físico, ya sea contar sus pasos, mantener un control de distancia, calorías quemadas o tiempo activo. Puede seguir su rendimiento actual en esta pantalla. También puedes ver registros de días anteriores aquí. Puede iniciar / detener el seguimiento del rendimiento con el botón de encendido en la parte superior derecha de la pantalla. El círculo a la izquierda muestra el estado de la caminata, ya sea que esté caminando, corriendo o estática. El círculo a la derecha muestra que PACER está siguiendo tu caminata o no. Mientras que los pasos dados y el logro del objetivo se muestran en el medio.',
    'guide_track':
        'Aquí puede ver las pistas grabadas de la fecha actual en el mapa. Puede ver el mapa en vista de terreno y satélite cambiando su tipo. También puede marcar cualquier lugar como su lugar favorito y compartirlo o la ubicación actual a través de cualquier medio para compartir. Seleccione el marcador de lugar en el mapa para compartirlo o eliminarlo.',
    'guide_widgets':
        'Esta pantalla muestra la dirección, temperatura, humedad, horarios de puesta de sol / amanecer y la dirección de su ubicación actual. También muestra tu velocidad actual. Puede ENCENDER / APAGAR la luz del flash de su teléfono usando el botón de la luz del flash',
    'hello_blank_fragment': 'Hola fragmento en blanco',
    'highspeed': 'Alta velocidad',
    'history': 'Historia',
    'letsgo': 'Vamonos',
    'likeus': 'Como nosotros',
    'monthly': 'Mensual',
    'moreapps': 'Más aplicaciones',
    'needspermission':
        'Esta aplicación necesita permiso para usar esta función. Puede otorgarlos en la configuración de la aplicación.',
    'no': 'No',
    'ok': 'Okay',
    'performance': 'Actuación',
    'placeaddedsucessfully': 'Su lugar ha sido agregado exitosamente',
    'placedeleted': 'Lugar eliminado correctamente',
    'progress': 'Progreso',
    'privacypolicy': 'Política de privacidad',
    'recordingtrack': 'Rastreo',
    'running': 'Corriendo',
    'satelite': 'Satélite',
    'save': 'Salvar',
    'servicestarted': 'Pacer está rastreando tus caminatas ahora',
    'servicestoped': 'Establece el recuento como en pausa',
    'shareapp': 'Compartir aplicación',
    'slogan': 'Estar en forma Estar saludable',
    'speed': 'VELOCIDAD',
    'staticposition': 'Estático',
    'steps': 'Pasos',
    'suretoturnoff': '¿Seguro que quieres desactivar el seguimiento?',
    'terrain': 'Terreno',
    'text_share_img_btm': 'Sigue caminando y mantente saludable con PACER',
    'text_shareloc':
        'Rastree el rendimiento de su día a día con PACER: una aplicación de seguimiento de pasos y pasos',
    'time': 'Hora',
    'today': 'Hoy',
    'totalcalsburn': 'Calorías totales quemadas',
    'totaldistancecovered': 'Distancia total cubierta',
    'totalstepstaken': 'Pasos totales tomados',
    'track': 'Pista',
    'tracking': 'Rastreo',
    'trackingstoped': 'Rastreo',
    'turnoff': 'Apagar',
    'unknown': 'Desconocido',
    'walking': 'Caminando',
    'website': 'Sitio web',
    'weekly': 'Semanal',
    'welcome': 'Bienvenidos',
    'widgets': 'Widgets',
    'yearly': 'Anual',
    'yes': 'si',
    'help': 'Ayuda',
    'internetnotconnected': 'Conectarse con internet',
    'nothanks': 'No, gracias',
    'txt_netorlocationerror':
        'Encienda su ubicación de Internet y GPS para obtener las cifras a continuación',
    'txt_promotion':
        'PACER proporciona widgets y funciones de soporte para caminar. Pruebe nuestro Free & Aplicación de seguimiento de vehículos liviana con soporte de navegación de conducción.',
    'clicktoinstall': 'Haga clic aquí para instalar',
    'promotioalad': 'Anuncio promocional',
    'featurenotsupported': 'Característica no compatible con su dispositivo',
    'language': 'Idioma',
    'showingads': 'Mostrando anuncios ...',
    'sensorinfo_detector': 'Sensor de paso dedicado activado',
    'sensorinfo_counter': 'Sensor de paso dedicado activado',
    'sensorinfo_accelerometer': 'Usar sensores alternativos',
    'sensorinfo_nosensor': 'No se encontró ningún sensor de pasos',
    'stepsensor': 'Sensor de paso',
    'details': 'Detalles',
    'sensor_message':
        'PACER utiliza varios sensores de dispositivo para detectar los pasos alternativamente. El "SENSOR DETECTOR DE PASOS" dedicado ofrece el mejor rendimiento para detectar los pasos, pero si no se encuentra en el dispositivo, el PACER utiliza "SENSORES ALTERNOS" para detectar los pasos. La detección de pasos puede ser ineficaz debido a la ausencia de un "SENSOR DETECTOR DE PASOS" dedicado en el dispositivo. Para mejorar el rendimiento con "SENSORES ALTERNOS", se recomienda utilizar Pacer con la ubicación GPS activada. Si no se encuentra ningún sensor en el dispositivo que pueda ayudar en la detección de pasos, se muestra el mensaje "No se encontró sensor de paso".',
    'trackingmsg': 'Pista de grabación',
    'location': 'Ubicación',
    'locationIsOnMsg': 'La ubicación ya está activada',
    'duration': 'Duración',
    'walk_status': 'Estado de caminata',
    'running_desc':
        'Este icono indica que el modo de ejecución se ha activado ahora porque PACER ha detectado que el dispositivo se está moviendo con el ritmo de ejecución adecuado.',
    'walking_desc':
        'Este icono indica que se ha activado el modo de caminar porque PACER ha detectado el movimiento del dispositivo con el ritmo adecuado para caminar.',
    'staticposition_desc':
        'Este icono indica que el titular del dispositivo no está caminando ni corriendo, sino en modo estático.',
    'ws_msg_1':
        'Estos iconos muestran el estado actual del movimiento como se menciona a continuación:',
  };

  static const Map<String, String> ar = {
    'appName': 'بيسر',
    'unknown': 'مجهول',
    'slogan': 'كن بصحة جيدة',
    'widgets': 'الحاجيات',
    'history': 'التاريخ',
    'goal': 'هدف',
    'track': 'المسار',
    'hello_blank_fragment': 'مرحبًا بجزء فارغ',
    'performance': 'أداء',
    'distance': 'مسافة',
    'calories': 'سعرات حراريه',
    'time': 'زمن',
    'tracking': 'تتبع',
    'walking': 'يمشي',
    'steps': 'خطوات',
    'completed': 'منجز',
    'goalsetting': 'تحديد الأهداف',
    'goal_cals': 'سعرات حراريه (kcal)',
    'goal_steps': 'خطوات',
    'goal_distance': 'مسافة (km)',
    'prgress': 'تقدم',
    'totalcalsburn': 'مجموع السعرات الحرارية المحروقة',
    'totalstepstaken': 'إجمالي الخطوات التي تم اتخاذها',
    'totaldistancecovered': 'إجمالي المسافة المقطوعة',
    'avgcalburned': 'متوسط ​​السعرات الحرارية المحروقة',
    'direction': 'اتجاه',
    'speed': 'سرعة',
    'flashlight': 'ضوء الفلاش',
    'daily': 'اليومي',
    'monthly': 'شهريا',
    'weekly': 'أسبوعي',
    'yearly': 'سنوي',
    'moreapps': 'تطبيقات أكثر',
    'shareapp': 'شارك التطبيق',
    'feedback': 'ردود الفعل',
    'likeus': 'مثلنا',
    'privacypolicy': 'سياسة خاصة',
    'website': 'موقع الكتروني',
    'goalsaved': 'تم تحديث الهدف بنجاح',
    'NeedPermissions': 'تحتاج أذونات',
    'needspermission':
        'يحتاج هذا التطبيق إلى إذن لاستخدام هذه الميزة. يمكنك منحهم في إعدادات التطبيق.',
    'GOTOSETTINGS': 'اذهب للاعدادات',
    'Cancel': 'إلغاء',
    'turnoff': 'أطفأ',
    'suretoturnoff': 'هل أنت متأكد أنك تريد إيقاف؟',
    'yes': 'نعم',
    'no': 'لا',
    'servicestoped': 'ضبط العد كما تم إيقافه مؤقتًا',
    'servicestarted': 'يتتبع بيسر مناحيك الآن',
    'today': 'اليوم',
    'running': 'ادارة',
    'staticposition': 'ثابتة',
    'highspeed': 'سرعة عالية',
    'recordingtrack': 'تتبع',
    'trackingstoped': 'تتبع',
    'humidity': 'رطوبة',
    'sunrise': 'شروق الشمس',
    'sunset': 'غروب الشمس',
    'Addressnotfound': 'لم يتم العثور على عنوان',
    'choosemaptype': 'اختر نوع الخريطة',
    'terrain': 'تضاريس',
    'satelite': 'الأقمار الصناعية',
    'defaultmap': 'إفتراضي',
    'addmyplace': 'أضف مكانًا',
    'LocationName': 'اسم الموقع',
    'LocationAddress': 'عنوان',
    'SelectCategory': 'اختر الفئة',
    'save': 'حفظ',
    'fillfieldtoproceed': 'يرجى ملء هذا الحقل للمتابعة',
    'placeaddedsucessfully': 'تمت إضافة مكانك بنجاح',
    'letsgo': 'لنذهب',
    'currentweek': 'الأسبوع الحالي',
    'erroraqruiringdata': 'خطأ في الحصول على البيانات',
    'text_share_img_btm': 'استمر في المشي وحافظ على صحتك مع بيسر',
    'chooselanguage': 'اختر اللغة',
    'ok': 'حسنا',
    'gotit': 'فهمتك',
    'welcome': 'أهلا بك',
    'guide_performance':
        'يسمح لك بيسر بتتبع جميع أساسيات اللياقة البدنية سواء كانت تحسب خطواتك أو تحافظ على فحص المسافة أو السعرات الحرارية المحروقة أو الوقت النشط. يمكنك متابعة أدائك الحالي على هذه الشاشة. كما يمكنك مشاهدة سجلات الأيام السابقة هنا. يمكنك بدء / إيقاف تتبع أدائك باستخدام زر الطاقة في أعلى يمين الشاشة. تُظهر الدائرة الموجودة على اليسار حالة المشي إما أنك تمشي أو تجري أو تكون ثابتًا. تُظهر الدائرة على اليمين إما أن بيسر يتعقب مشيتك أم لا. بينما تظهر الخطوات المتخذة وتحقيق الهدف في المنتصف.',
    'guide_goal':
        'هنا يمكنك جدولة وتحديد روتين اللياقة البدنية الأسبوعي الخاص بك. الأهداف. حدد اليوم وأدخل القيمة في أي من الحقول التي ستقوم فيها تلقائيًا بحساب القيمة المقدرة للحقول الأخرى. يظهر مخطط الجدول في الأسفل الذي يوضح المقارنة بين الأهداف المجدولة لأيام الأسبوع.',
    'guide_history':
        'هنا يمكنك الحصول على نظرة عامة على أدائك الأسبوعي أو الشهري أو السنوي في شكل رسوم بيانية. يمكنك أيضًا مشاركة أدائك باستخدام زر المشاركة أعلى يمين الشاشة.',
    'guide_track':
        'هنا يمكنك رؤية المسارات المسجلة للتاريخ الحالي على الخريطة. يمكنك عرض الخريطة في عرض التضاريس والأقمار الصناعية عن طريق تغيير نوعها. يمكنك أيضًا وضع علامة على أي مكان كمكان مفضل ومشاركته أو الموقع الحالي عبر أي وسائط مشاركة. حدد علامة مكان على الخريطة لمشاركتها أو حذفها.',
    'guide_widgets':
        'تعرض هذه الشاشة العنوان ودرجة الحرارة والرطوبة وتوقيت الغروب / شروق الشمس واتجاه موقعك الحالي. كما تظهر سرعتك الحالية. يمكنك تشغيل / إيقاف ضوء الفلاش الخاص بهاتفك باستخدام زر "ضوء الفلاش".',
    'delete': 'حذف',
    'deleteplace': 'حذف المكان',
    'deleteplacetext': 'هل تريد حذف المكان المحدد؟',
    'placedeleted': 'تم حذف المكان بنجاح',
    'text_shareloc':
        'تتبع أداء حياتك اليومية باستخدام PACER: تطبيق تعقب الخطوات والمشي',
    'help': 'مساعدة',
    'internetnotconnected': 'تواصل مع الإنترنت',
    'nothanks': 'لا شكرا',
    'txt_netorlocationerror':
        'قم بتشغيل الإنترنت وموقع GPS الخاص بك للحصول على الأرقام أدناه',
    'txt_promotion':
        'يوفر PACER أدوات وميزات دعم المشي. جرب برنامج Free & تطبيق CAR TRACKER خفيف الوزن مع دعم التنقل أثناء القيادة.',
    'clicktoinstall': 'انقر هنا للتثبيت',
    'promotioalad': 'إعلان ترويجي',
    'featurenotsupported': 'الميزة غير مدعومة مع جهازك',
    'language': 'لغة',
    'showingads': 'عرض الإعلانات ...',
    'sensorinfo_detector': 'تم تنشيط مستشعر الخطوات المخصص',
    'sensorinfo_counter': 'تم تنشيط مستشعر الخطوات المخصص',
    'sensorinfo_accelerometer': 'استخدام مجسات بديلة',
    'sensorinfo_nosensor': 'لم يتم العثور على أداة استشعار الخطوة',
    'stepsensor': 'جهاز استشعار الخطوة',
    'details': 'تفاصيل',
    'sensor_message':
        'يستخدم PACER مستشعرات مختلفة للجهاز لاكتشاف الخطوات بدلاً من ذلك. مخصص "STEP DETECTOR SENSOR" يعطي أفضل أداء لاكتشاف الخطوات ولكن إذا لم يتم العثور عليه في الجهاز ، فإن PACER تستخدم "ALTERNATE SENSORS" لاكتشاف الخطوات. قد يكون اكتشاف الخطوات غير فعال بسبب عدم وجود "جهاز استشعار الخطوة" المخصص في الجهاز. لتحسين الأداء باستخدام "ALTERNATE SENSORS" ، يوصى باستخدام Pacer مع تشغيل موقع GPS. إذا لم يتم العثور على جهاز استشعار في الجهاز يمكن أن يساعد في اكتشاف الخطوات ، فسيتم عرض رسالة "No Step Sensor Found".',
    'trackingmsg': 'تسجيل المسار',
    'location': 'موقعك',
    'locationIsOnMsg': 'الموقع قيد التشغيل بالفعل',
    'duration': 'المدة الزمنية',
    'walk_status': 'حالة المشي',
    'ws_msg_1': 'توضح هذه الرموز الوضع الحالي للحركة كما هو مذكور أدناه:',
    'staticposition_desc':
        'يشير هذا الرمز إلى أن حامل الجهاز لا يمشي ولا يركض ولكنه في الوضع الثابت.',
    'walking_desc':
        'يشير هذا الرمز إلى أنه تم تنشيط وضع المشي لأن PACER اكتشف حركة الجهاز في نظام المشي المناسب.',
    'running_desc':
        'يشير هذا الرمز إلى أنه تم تنشيط وضع التشغيل الآن لأن PACER اكتشف أن الجهاز يتحرك في نظام التشغيل الصحيح.',
  };

  static const Map<String, Map<String, String>> translations = {
    'en': en,
    'pt': pt,
    'hi': hi,
    'fr': fr,
    'es': es,
    'de': de,
    'ar': ar
  };
}
