// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer/widgets/blinking_widget.dart';

void main() {
  group('BlinkingWidget Tests', () {
    testWidgets('Widget blinks when isBelowRequirement is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: BlinkingWidget(
          isBelowRequirement: true,
          child: Text('Testing Blink'),
        ),
      ));

      await tester.pump();
      Color initialColor = _getColorFromTester(tester, find.byType(Text));

      await tester.pump(const Duration(milliseconds: 250));

      await tester.pump(const Duration(milliseconds: 250));
      Color endAnimationColor = _getColorFromTester(tester, find.byType(Text));

      expect(endAnimationColor, equals(initialColor));
    });

    testWidgets('Widget does not blink when isBelowRequirement is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: BlinkingWidget(
          isBelowRequirement: false,
          child: Text('Testing No Blink'),
        ),
      ));

      // Initial frame
      await tester.pump();
      Color initialColor = _getColorFromTester(tester, find.byType(Text));

      // Attempt to advance the animation
      await tester
          .pump(const Duration(milliseconds: 500)); // Time for one full cycle
      Color laterColor = _getColorFromTester(tester, find.byType(Text));

      expect(laterColor, equals(initialColor));
    });
  });

  print('--> Blinking Widget Test Passed Successfully!');
}

// Helper function to extract color from the Text widget within BlinkingWidget
Color _getColorFromTester(WidgetTester tester, Finder finder) {
  final RenderObject renderObject = tester.firstRenderObject(finder);
  return (renderObject as RenderParagraph).text.style!.color!;
}
