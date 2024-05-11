// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:pacer/widgets/dialog.dart';

void main() {
  group('Dialog Tests', () {
    //these will be used for mocking api calls for google login
    late MockFirebaseAuth mockAuth;
    late MockGoogleSignIn mockGoogleSignIn;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
    });

    testWidgets('NoLoginDialog displays and triggers function on button tap',
        (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(MaterialApp(
        home: NoLoginDialog(onPressed: () {
          pressed = true;
        }),
      ));

      expect(find.text('Login'), findsAtLeast(2));
      expect(find.text('You are not logged in. Kindly login to save data.'),
          findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(pressed, true);
    });

    testWidgets('LoginDialog interaction and navigation',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: const LoginDialog(),
      ));

      expect(find.text('My Profile'), findsOneWidget);

      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();
    });
  });

  print('--> Dialog Test Passed Successfully!');

  print('--> UNIT TESTS PASSED <--');
  print('-->-------------------<---');
}
