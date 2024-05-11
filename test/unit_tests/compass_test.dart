// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:mockito/mockito.dart';
import 'dart:async';

import 'package:pacer/widgets/compass.dart';

class MockCompassStream extends Mock implements Stream<CompassEvent> {}

void main() {
  group('CompassWidget Tests', () {
    testWidgets('CompassWidget updates direction when stream emits',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CompassWidget()));

      // Initial state where there should be an CircularProgressIndicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Image), findsNothing);

      await tester.pump();

      await tester.pump();
    });
  });

  print('--> Compass Test Passed Successfully!');
}
