// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer/widgets/drawer.dart';

void main() {
  testWidgets('Navigation Drawer test', (WidgetTester tester) async {
    Widget testWidget = MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MyNavigationDrawer("en", 0);
          },
        ),
      ),
    );

    await tester.pumpWidget(testWidget);

    expect(find.text('More Apps'), findsOneWidget);
    expect(find.text('Share App'), findsOneWidget);
    expect(find.text('Feedback'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Help'), findsOneWidget);

    print('--> Drawer Test Passed Successfully!');
  });
}
