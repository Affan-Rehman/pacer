// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class MyNavigationDrawer extends StatelessWidget {
  String currentLanguage;

  int currentItem;
  MyNavigationDrawer(this.currentLanguage, this.currentItem);

  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gPrimaryDark,
              AppColors.gPrimaryLight
            ], // Replace with your colors
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30), // Adjust as needed
            Text(
              translatedStrings[currentLanguage]!['appName'] ??
                  AppStrings.appName, // Replace with your app name
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              translatedStrings[currentLanguage]!['slogan'] ??
                  AppStrings.slogan, // Replace with your slogan
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30), // Adjust as needed
            Divider(color: Color(0xFFB4B4B4)), // Adjust color as needed
            SizedBox(height: 30), // Adjust as needed
            ListTile(
              leading: Icon(Icons.apps, color: Colors.white),
              title: Text(
                translatedStrings[currentLanguage]!['moreapps'] ??
                    AppStrings.moreApps,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                launch("https://charismaapps.co/html/apps.html");
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.white),
              title: Text(
                translatedStrings[currentLanguage]!['shareapp'] ??
                    AppStrings.shareApp,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                String playStoreLink = AppStrings.appLink;
                String yourShareText = 'Share App: $playStoreLink';

                Share.share(
                  yourShareText,
                  subject: translatedStrings[currentLanguage]!['appName'] ??
                      AppStrings.appName,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback, color: Colors.white),
              title: Text(
                translatedStrings[currentLanguage]!['feedback'] ??
                    AppStrings.feedback,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                openEmailScreen(AppStrings.email);
              },
            ),
            ListTile(
              leading: Icon(Icons.thumb_up, color: Colors.white),
              title: Text(
                translatedStrings[currentLanguage]!['likeus'] ??
                    AppStrings.likeUs,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                launch(AppStrings.appLink);
              },
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.white),
              title: Text(
                translatedStrings[currentLanguage]!['privacypolicy'] ??
                    AppStrings.privacyPolicy,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showPrivacyPolicy(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.white),
              title: Text(
                translatedStrings[currentLanguage]!['help'] ?? AppStrings.help,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                help(context, currentItem);
              },
            ),
                      ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                translatedStrings[currentLanguage]!['logout'] ??
                    AppStrings.logout,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void launch(String website) async {
    Uri url = Uri.parse(website);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void openEmailScreen(String recipient) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: recipient,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open email screen';
    }
  }

  void showPrivacyPolicy(BuildContext context) {
    String website = AppStrings.privacyUrl;

    final spannableString = TextSpan(
      text: "${AppStrings.privacyText} website\n",
      style: TextStyle(color: Colors.black),
      children: [
        TextSpan(
          text: website,
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch(website);
            },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(translatedStrings[currentLanguage]!['privacypolicy'] ??
              AppStrings.privacyPolicy),
          content: SingleChildScrollView(
            child: RichText(
              text: spannableString,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(translatedStrings[currentLanguage]!['ok'] ??
                  AppStrings.gotIt),
            ),
          ],
        );
      },
    );
  }

  void showGuide(BuildContext context, String title, String guideText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(guideText),
          actions: <Widget>[
            TextButton(
              child: Text(AppStrings.gotIt),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void help(BuildContext context, int currentItem) {
    switch (currentItem) {
      case 0:
        showGuide(
            context,
            translatedStrings[currentLanguage]!['widgets'] ??
                AppStrings.widgets,
            translatedStrings[currentLanguage]!['guide_widgets'] ??
                AppStrings.guideWidgets);
        break;
      case 1:
        showGuide(
            context,
            translatedStrings[currentLanguage]!['track'] ?? AppStrings.track,
            translatedStrings[currentLanguage]!['guide_track'] ??
                AppStrings.guideTrack);
        break;
      case 2:
        showGuide(
            context,
            translatedStrings[currentLanguage]!['performance'] ??
                AppStrings.performance,
            translatedStrings[currentLanguage]!['guide_performance'] ??
                AppStrings.guidePerformance);
        break;
      case 3:
        showGuide(
            context,
            translatedStrings[currentLanguage]!['goal'] ?? AppStrings.goal,
            translatedStrings[currentLanguage]!['guide_goal'] ??
                AppStrings.guideGoal);
        break;
      case 4:
        showGuide(
            context,
            translatedStrings[currentLanguage]!['history'] ??
                AppStrings.history,
            translatedStrings[currentLanguage]!['guide_history'] ??
                AppStrings.guideHistory);
        break;
    }
  }
}
