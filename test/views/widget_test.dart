import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  // Helper to tap a button by its label.
  Future<void> tapButton(WidgetTester tester, String label) async {
    await tester.tap(find.widgetWithText(ElevatedButton, label));
    await tester.pump();
  }

  group('OrderScreen basics', () {
    testWidgets('initial UI renders', (tester) async {
      await tester.pumpWidget(const App());
      // Confirm type dropdown text present
      expect(find.text('Veggie Delight'), findsOneWidget);

      // Bread (case-insensitive fallback)
      final breadFinder = find.text('white');
      expect(breadFinder, findsAtLeastNWidgets(1));

      // Quantity exact (adjust to your real default)
      final startsAtZero = find.text('0').evaluate().isNotEmpty;
      final startsAtOne = find.text('1').evaluate().isNotEmpty;
      expect(startsAtZero || startsAtOne, isTrue);

      // Add to Cart button
      expect(
          find.widgetWithText(ElevatedButton, 'Add to Cart'), findsOneWidget);
    });
  });

  group('Changing sandwich type', () {
    testWidgets('changes type via dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Open dropdown (use key if available, else byType)
      final typeDropdown =
          find.byType(DropdownMenu<SandwichType>).evaluate().isNotEmpty
              ? find.byType(DropdownMenu<SandwichType>)
              : find.byType(DropdownMenu);
      await tester.tap(typeDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();
      expect(find.text('Chicken Teriyaki'), findsOneWidget);
    });
  });

  group('Changing bread type', () {
    testWidgets('changes bread via dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final breadDropdown =
          find.byKey(const Key('bread_dropdown')).evaluate().isNotEmpty
              ? find.byKey(const Key('bread_dropdown'))
              : find.byType(DropdownMenu);
      // wheat
      await tester.tap(breadDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      expect(find.text('wheat'), findsWidgets);
      // wholemeal
      await tester.tap(breadDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('wholemeal').last);
      await tester.pumpAndSettle();
      expect(find.text('wholemeal'), findsWidgets);
    });
  });

  group('Quantity controls', () {
    testWidgets('increments and decrements quantity safely', (tester) async {
      await tester.pumpWidget(const App());
      // Determine initial
      int initial = find.text('1').evaluate().isNotEmpty ? 1 : 0;

      // Increment once
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('${initial + 1}'), findsOneWidget);

      // Decrement back (if >0)
      if (initial + 1 > 0) {
        await tester.tap(find.byIcon(Icons.remove));
        await tester.pump();
        expect(find.text('$initial'), findsOneWidget);
      }

      // Attempt to go below zero
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('SnackBar messages', () {
    testWidgets('shows SnackBar on add', (tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.textContaining('Added'),
        findsOneWidget,
      );
    });
  });

  group('Size switch', () {
    testWidgets('toggles size switch', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Prefer key if exists
      final sizeSwitchFinder =
          find.byKey(const Key('size_switch')).evaluate().isNotEmpty
              ? find.byKey(const Key('size_switch'))
              : find.byType(Switch);

      Switch sizeSwitch = tester.widget(sizeSwitchFinder);
      expect(sizeSwitch.value, isTrue); // initial footlong

      await tester.tap(sizeSwitchFinder);
      await tester.pump();

      sizeSwitch = tester.widget(sizeSwitchFinder);
      expect(sizeSwitch.value, isFalse); // now six-inch
    });
  });
}
