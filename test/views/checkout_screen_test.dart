import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';

void main() {
  group('CheckoutScreen', () {
    testWidgets('shows order summary and totals for cart items',
        (WidgetTester tester) async {
      final cart = Cart();
      final sandwich1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final sandwich2 = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      // PricingRepository: assume 11 for footlong, 7 for six-inch
      cart.add(sandwich1, quantity: 2); // 2 x 11 = 22
      cart.add(sandwich2, quantity: 1); // 1 x 7 = 7
      // total = 29

      await tester.pumpWidget(
        MaterialApp(
          home: CheckoutScreen(cart: cart),
        ),
      );

      // App bar and heading
      expect(find.text('Checkout'), findsOneWidget);
      expect(find.text('Order Summary'), findsOneWidget);

      // Line items
      expect(find.text('2x Veggie Delight'), findsOneWidget);
      expect(find.text('1x Chicken Teriyaki'), findsOneWidget);

      expect(find.text('£22.00'), findsOneWidget);
      expect(find.text('£7.00'), findsOneWidget);

      // Total row
      expect(find.text('Total:'), findsOneWidget);
      expect(find.text('£29.00'), findsOneWidget);

      // Payment method and button
      expect(find.text('Payment Method: Card ending in 1234'), findsOneWidget);
      expect(find.text('Confirm Payment'), findsOneWidget);
    });

    testWidgets('shows processing UI when confirming payment',
        (WidgetTester tester) async {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      await tester.pumpWidget(
        MaterialApp(
          home: CheckoutScreen(cart: cart),
        ),
      );

      // Initially, button is visible, no progress indicator
      expect(find.text('Confirm Payment'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Processing payment...'), findsNothing);

      // Tap confirm payment
      await tester.tap(find.text('Confirm Payment'));
      await tester.pump(); // start async operation, setState called

      // While processing
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Processing payment...'), findsOneWidget);
      // Button should be gone
      expect(find.text('Confirm Payment'), findsNothing);
    });

    testWidgets('pops with order confirmation after processing payment',
        (WidgetTester tester) async {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2); // 2 x 11 = 22

      Object? poppedResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Navigator(
                onPopPage: (route, result) {
                  poppedResult = result;
                  return route.didPop(result);
                },
                pages: [
                  MaterialPage(
                    child: CheckoutScreen(cart: cart),
                  ),
                ],
              );
            },
          ),
        ),
      );

      // Tap confirm payment
      await tester.tap(find.text('Confirm Payment'));
      await tester.pump(); // start processing

      // Advance fake time by 2 seconds to finish Future.delayed
      await tester.pump(const Duration(seconds: 2));

      // After payment completes, screen should have popped
      expect(poppedResult, isNotNull);
      expect(poppedResult, isA<Map>());

      final Map confirmation = poppedResult as Map;
      expect(confirmation['totalAmount'], 22.0);
      expect(confirmation['itemCount'], 2);
      expect(confirmation['orderId'], isA<String>());
      expect(confirmation['estimatedTime'], '15-20 minutes');
    });
  });
}
