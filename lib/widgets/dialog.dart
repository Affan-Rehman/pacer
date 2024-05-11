// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../helper/classes.dart';

class NoLoginDialog extends StatelessWidget {
  final Function onPressed;

  const NoLoginDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: AppColors.colorPrimaryDark,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'You are not logged in. Kindly login to save data.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        AppColors.colorPrimaryDark, // Set the text color
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  backgroundColor: AppColors.colorPrimaryDark,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Text(
                    "My Profile",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Google Sign in required!",
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: AppColors.colorPrimaryDark,
                  ),
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By Signing in, you accept our",
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: AppColors.colorPrimaryDark,
                      ),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () async {
                              if (Platform.isIOS) {
                                await launchUrl(
                                  Uri.parse(AppStrings.privacyUrl),
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                await launchUrl(
                                  Uri.parse(AppStrings.privacyUrl),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                            child: Text("Terms of use"),
                          ),
                          style: const TextStyle(
                            fontSize: 15.0,
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent,
                          ),
                        ),
                        TextSpan(
                          text: " and ",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () async {
                              if (Platform.isIOS) {
                                await launchUrl(
                                  Uri.parse(AppStrings.privacyUrl),
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                await launchUrl(
                                  Uri.parse(AppStrings.privacyUrl),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                            child: Text("Privacy Policy"),
                          ),
                          style: const TextStyle(
                            fontSize: 15.0,
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorPrimaryDark,
                        elevation: 0),
                    onPressed: () async {
                      if (mounted) {
                        setState(() {
                          isloading = true;
                        });
                      }
                      try {
                        User? user;
                        if (Platform.isIOS) {
                          user = await AuthService.signInWithApple(
                              context: context);
                        } else {
                          user = await AuthService.signInWithGoogle(
                              context: context);
                        }
                        if (user != null) {
                          await AuthService.adduserdetails(user, context);
                          Navigator.pop(context);
                        }
                        if (mounted) {
                          setState(() {
                            isloading = false;
                          });
                        }
                      } catch (e) {
                        if (mounted) {
                          setState(() {
                            isloading = false;
                          });
                        }
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Platform.isAndroid
                              ? Ionicons.logo_google
                              : Platform.isIOS
                                  ? Ionicons.logo_apple
                                  : Icons.error,
                          color: Platform.isAndroid ? Colors.red : Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign In",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                Visibility(
                  visible: !isloading,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorPrimaryDark,
                          elevation: 0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "close",
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isloading)
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(child: CircularProgressIndicator())
                ],
              )
          ],
        ),
      ),
    );
  }
}

class AuthService {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    try {
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            showSnackBar(
                context,
                'The account already exists with a different credential.',
                1800);
          } else if (e.code == 'invalid-credential') {
            showSnackBar(context,
                'Error occurred while accessing credentials. Try again.', 1800);
          }
        } catch (e) {
          showSnackBar(
              context, 'Error occurred using Google Sign-In. Try again.', 1800);
        }
      }
    } catch (e) {
      log("exception in google dialog");
    }

    return user;
  }

  static void showSnackBar(BuildContext context, String s, int i) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
        ),
        duration: Duration(milliseconds: i),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Future<void> adduserdetails(User user, BuildContext context) async {
    try {
      // final fcmToken = await FirebaseMessaging.instance.getToken();
      if (await checkIfUserDocExists()) {
      } else {
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "userName": user.displayName,
          "phoneNumber": user.phoneNumber ?? "",
          "profileImgLink": user.photoURL ?? "",
          "uid": user.uid,
        });
      }
      showSnackBar(context, "Logged in", 1200);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString(), 1000);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<User?> signInWithApple({required BuildContext context}) async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your_client_id',
          redirectUri: Uri.parse('your_redirect_uri'),
        ),
      );

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final OAuthCredential credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await adduserdetails(user, context);
      }

      return user;
    } catch (error) {
      showSnackBar(
          context, 'Error occurred during Apple Sign-In. Try again.', 1800);
      return null;
    }
  }
}

class DialogLanguages extends StatelessWidget {
  final Function(String) onLanguageSelected;

  DialogLanguages(
      {required this.onLanguageSelected, required this.currentLanguage});
  String currentLanguage = "en";
  Map<String, Map<String, String>> translatedStrings = AppStrings.translations;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    translatedStrings[currentLanguage]?['chooselanguage'] ??
                        AppStrings.chooseLanguage,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return LanguageButton(
                  language: list[index].language,
                  iconAsset: list[index].iconAsset,
                  onPressed: () {
                    onLanguageSelected(list[index].languageCode);

                    Navigator.pop(context);

                    AnimatedSnackBar(
                      builder: (context) {
                        return Container(
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          color: const Color.fromARGB(
                              255, 0, 0, 0), // Customize the color here
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors
                                    .white, // Customize the icon color here
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Language changed',
                                style: TextStyle(
                                  color: Colors
                                      .white, // Customize the text color here
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      duration: Duration(seconds: 3),
                    ).show(context);
                  },
                );
              },
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String language;
  final String iconAsset;
  final VoidCallback onPressed;

  const LanguageButton({
    required this.language,
    required this.iconAsset,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: IconButton(
            iconSize: 24.0,
            icon: Image.asset(iconAsset),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          language,
          style: TextStyle(
            fontSize: 8.0,
          ),
        ),
      ],
    );
  }
}

class IconModel {
  final String language;
  final String languageCode;
  final String iconAsset;

  const IconModel({
    required this.language,
    required this.languageCode,
    required this.iconAsset,
  });
}

// Create the list of languages and icons
List<IconModel> list = [
  IconModel(
    language: 'English',
    languageCode: 'en',
    iconAsset: 'assets/drawable/uk.png',
  ),
  IconModel(
    language: 'Français',
    languageCode: 'fr',
    iconAsset: 'assets/drawable/france.png',
  ),
  IconModel(
    language: 'العربية',
    languageCode: 'ar',
    iconAsset: 'assets/drawable/saudia.png',
  ),
  IconModel(
    language: 'Español',
    languageCode: 'es',
    iconAsset: 'assets/drawable/spain.png',
  ),
  IconModel(
    language: 'Português',
    languageCode: 'pt',
    iconAsset: 'assets/drawable/portugal.png',
  ),
  IconModel(
    language: 'Deutsche',
    languageCode: 'de',
    iconAsset: 'assets/drawable/german.png',
  ),
  IconModel(
    language: 'हिंदी',
    languageCode: 'hi',
    iconAsset: 'assets/drawable/india.png',
  ),
];
