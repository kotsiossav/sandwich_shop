import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

/// Helper: Ensures the screen is large enough for all widgets.
Future<void> pumpWithLargeScreen(WidgetTester tester, Widget widget) async {
  tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
  tester.binding.window.devicePixelRatioTestValue = 1.0;

  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);

  await tester.pumpWidget(widget);
}

void main() {
  testWidgets('App loads and shows OrderScreen', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const App(),
    );

    expect(find.byType(OrderScreen), findsOneWidget);
  });

  testWidgets('Quantity increases when + button is pressed', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 5)),
    );

    final increaseButton = find.byIcon(Icons.add);
    expect(increaseButton, findsOneWidget);

    await tester.tap(increaseButton);
    await tester.pump();

    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Quantity decreases when - button is pressed', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 5)),
    );

    final increase = find.byIcon(Icons.add);
    final decrease = find.byIcon(Icons.remove);

    // Increase twice → quantity becomes 3
    await tester.tap(increase);
    await tester.tap(increase);
    await tester.pump();

    expect(find.text('3'), findsOneWidget);

    // Now decrease → should become 2
    await tester.tap(decrease);
    await tester.pump();

    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Quantity does not go below 0', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 5)),
    );

    final decrease = find.byIcon(Icons.remove);

    // Initial quantity = 1 (from your code)
    await tester.tap(decrease);
    await tester.pumpAndSettle();

    // Now it should be "0"
    expect(find.text('0'), findsOneWidget);

    // Try decreasing again → stays at 0
    await tester.tap(decrease);
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Quantity cannot exceed maxQuantity = 10', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 10)),
    );

    // Find the actual IconButton, not the Icon
    final plusButtonFinder = find.widgetWithIcon(IconButton, Icons.add);

    // Tap + many times
    for (int i = 0; i < 20; i++) {
      await tester.tap(plusButtonFinder);
      await tester.pump();
    }

    // Quantity should be exactly "10"
    expect(find.text('10'), findsOneWidget);

    // And button should now be disabled
    final IconButton plusButton = tester.widget(plusButtonFinder);
    expect(plusButton.onPressed, isNull);
  });

  testWidgets('Footlong switch toggles correctly', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 5)),
    );

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    // Initially true
    Switch toggle = tester.widget(switchFinder);
    expect(toggle.value, true);

    await tester.tap(switchFinder);
    await tester.pump();

    toggle = tester.widget(switchFinder);
    expect(toggle.value, false);
  });

  testWidgets('Add to Cart shows SnackBar', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 5)),
    );

    final addButton = find.text('Add to Cart');
    expect(addButton, findsOneWidget);

    await tester.tap(addButton);
    await tester.pump(); // begin animation
    await tester.pump(const Duration(seconds: 1)); // show snackbar

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Cart summary updates after adding items', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 5)),
    );

    final addButton = find.text('Add to Cart');
    final increase = find.byIcon(Icons.add);

    // Increase quantity to 2
    await tester.tap(increase);
    await tester.pump();

    // Add to cart
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Look for something like "Items: 2"
    expect(find.textContaining('2'), findsWidgets);
  });

  //Tests for the cart summary updates after adding items with different bread types
  testWidgets('Cart summary initially shows 0 items and £0.00', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 10)),
    );

    expect(find.text('Items: 0'), findsOneWidget);
    expect(find.text('Total: £0.00'), findsOneWidget);
  });

  testWidgets('Adding items updates cart summary', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 10)),
    );

    final addButton = find.text('Add to Cart');

    // Add 1 default (Veggie Delight footlong)
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('Items: 1'), findsOneWidget);
  });

  testWidgets('Cart summary reflects multiple quantity added', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 10)),
    );

    final addButton = find.text('Add to Cart');
    final plusButton = find.widgetWithIcon(IconButton, Icons.add);

    // Increase quantity from 1 to 3
    await tester.tap(plusButton);
    await tester.tap(plusButton);
    await tester.pump();

    // Add 3 items
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('Items: 3'), findsOneWidget);
  });

  testWidgets('Cart summary accumulates quantity when added twice',
      (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 10)),
    );

    final addButton = find.text('Add to Cart');

    // Add first item
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Add second item
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('Items: 2'), findsOneWidget);
  });

  testWidgets('Total price increases when items added', (tester) async {
    await pumpWithLargeScreen(
      tester,
      const MaterialApp(home: OrderScreen(maxQuantity: 10)),
    );

    final addButton = find.text('Add to Cart');

    // Capture initial total
    final initialTotal = find.textContaining('Total: £0.00');
    expect(initialTotal, findsOneWidget);

    // Add one item
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // New total must NOT be 0.00
    expect(find.text('Total: £0.00'), findsNothing);
  });
}
