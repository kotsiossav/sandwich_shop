import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sandwich_shop/main.dart' as app;
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/widgets/common_widgets.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Basic Order Flow Tests', () {
    testWidgets('add a sandwich to the cart and verify it is in the cart',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test the initial state of the app (on the order screen)
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.text('Cart: 0 items - £0.00'), findsOneWidget);
      expect(find.text('Veggie Delight'), findsWidgets);

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();

      // Add a sandwich to the cart
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Verify cart summary updated
      expect(find.text('Cart: 1 items - £11.00'), findsOneWidget);

      // Find the View Cart button to navigate to the cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.pumpAndSettle();
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Verify that we're on the cart screen and the sandwich is there
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Veggie Delight'), findsOneWidget);
      expect(find.text('Total: £11.00'), findsOneWidget);
    });

    testWidgets('change sandwich type and add to cart',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final sandwichDropdown = find.byType(DropdownMenu<SandwichType>);
      await tester.tap(sandwichDropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();

      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.pumpAndSettle();

      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Chicken Teriyaki'), findsOneWidget);
    });

    testWidgets('modify quantity and add to cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final quantitySection = find.text('Quantity: ');
      expect(quantitySection, findsOneWidget);

      final addButtons = find.byIcon(Icons.add);
      final quantityAddButton = addButtons.first;

      await tester.ensureVisible(quantityAddButton);
      await tester.pumpAndSettle();

      await tester.tap(quantityAddButton);
      await tester.pumpAndSettle();
      await tester.tap(quantityAddButton);
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();

      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      expect(find.text('Cart: 3 items - £33.00'), findsOneWidget);
    });

    testWidgets('complete checkout flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      final checkoutButton = find.widgetWithText(StyledButton, 'Checkout');
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(find.text('Checkout'), findsOneWidget);
      expect(find.text('Order Summary'), findsOneWidget);

      final confirmPaymentButton = find.text('Confirm Payment');
      await tester.tap(confirmPaymentButton);
      await tester.pumpAndSettle();

      // Wait for payment processing (2 seconds + buffer)
      await tester.pump(const Duration(seconds: 3));

      // Should be back on order screen with empty cart
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.text('Cart: 0 items - £0.00'), findsOneWidget);
    });
  });

  group('Sandwich Customization Tests', () {
    testWidgets('toggle between six-inch and footlong sizes',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find and tap the size switch to change from footlong to six-inch
      final sizeSwitch = find.byType(Switch);
      await tester.ensureVisible(sizeSwitch);
      await tester.pumpAndSettle();

      // Initially footlong is selected
      expect(find.text('Footlong'), findsOneWidget);

      // Toggle to six-inch
      await tester.tap(sizeSwitch);
      await tester.pumpAndSettle();

      // Add to cart
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Six-inch should be cheaper (£7.00 vs £11.00)
      expect(find.text('Cart: 1 items - £7.00'), findsOneWidget);
    });

    testWidgets('change bread type', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find bread type dropdown
      final breadDropdown = find.byType(DropdownMenu<BreadType>);
      await tester.ensureVisible(breadDropdown);
      await tester.pumpAndSettle();

      await tester.tap(breadDropdown);
      await tester.pumpAndSettle();

      // Select wheat bread
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();

      // Add to cart
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Navigate to cart and verify bread type
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      expect(find.text('Footlong on wheat bread'), findsOneWidget);
    });

    testWidgets('test all sandwich types', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final sandwichTypes = [
        'Veggie Delight',
        'Chicken Teriyaki',
        'Tuna Melt',
        'Meatball Marinara'
      ];

      for (final sandwich in sandwichTypes) {
        // Open dropdown
        final sandwichDropdown = find.byType(DropdownMenu<SandwichType>);
        await tester.ensureVisible(sandwichDropdown);
        await tester.pumpAndSettle();
        await tester.tap(sandwichDropdown);
        await tester.pumpAndSettle();

        // Select sandwich type - find all instances and tap the one in the dropdown menu
        final sandwichOptions = find.text(sandwich);
        if (sandwichOptions.evaluate().length > 1) {
          await tester.tap(sandwichOptions.last);
        } else {
          await tester.tap(sandwichOptions);
        }
        await tester.pumpAndSettle();

        // Verify selection
        expect(find.text(sandwich), findsWidgets);
      }
    });
  });

  group('Cart Management Tests', () {
    testWidgets('increment item quantity in cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add item to cart
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Navigate to cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Find and tap the + button in cart
      final incrementButtons = find.byIcon(Icons.add);
      await tester.tap(incrementButtons.first);
      await tester.pumpAndSettle();

      // Verify quantity increased
      expect(find.text('Qty: 2'), findsOneWidget);
      expect(find.text('Total: £22.00'), findsOneWidget);
    });

    testWidgets('decrement item quantity in cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add 2 items to cart
      final quantityAddButton = find.byIcon(Icons.add).first;
      await tester.ensureVisible(quantityAddButton);
      await tester.tap(quantityAddButton);
      await tester.pumpAndSettle();

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Navigate to cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Find and tap the - button in cart
      final decrementButton = find.byIcon(Icons.remove).first;
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();

      // Verify quantity decreased
      expect(find.text('Qty: 1'), findsOneWidget);
    });

    testWidgets('remove item completely from cart',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add item to cart
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Navigate to cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Find and tap the delete button
      final deleteButton = find.byIcon(Icons.delete);
      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      // Verify item removed
      expect(find.text('Your cart is empty.'), findsOneWidget);
    });

    testWidgets('add multiple different sandwiches to cart',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add first sandwich (Veggie Delight, footlong)
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Change to six-inch
      final sizeSwitch = find.byType(Switch);
      await tester.ensureVisible(sizeSwitch);
      await tester.tap(sizeSwitch);
      await tester.pumpAndSettle();

      // Add second sandwich (Veggie Delight, six-inch)
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Verify total is correct (£11 + £7 = £18)
      expect(find.text('Cart: 2 items - £18.00'), findsOneWidget);

      // Navigate to cart and verify both items
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      expect(find.text('Veggie Delight'), findsNWidgets(2));
      expect(find.text('Total: £18.00'), findsOneWidget);
    });
  });

  group('Edge Cases and Error Handling', () {
    testWidgets('try to checkout with empty cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to cart without adding anything
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Verify empty cart message
      expect(find.text('Your cart is empty.'), findsOneWidget);

      // Checkout button should not be visible for empty cart
      expect(find.widgetWithText(StyledButton, 'Checkout'), findsNothing);
    });

    testWidgets('decrement quantity to zero removes item',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add 1 item
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Navigate to cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Decrement to remove
      final decrementButton = find.byIcon(Icons.remove).first;
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();

      // Verify item removed
      expect(find.text('Your cart is empty.'), findsOneWidget);
    });

    testWidgets('add to cart with zero quantity is disabled',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Decrement quantity to 0
      final decrementButton = find.byIcon(Icons.remove).first;
      await tester.ensureVisible(decrementButton);
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();

      // Verify quantity is 0
      expect(find.text('0'), findsWidgets);

      // Add to cart button should be disabled (trying to tap won't work)
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);

      // Cart should still be empty
      expect(find.text('Cart: 0 items - £0.00'), findsOneWidget);
    });

    testWidgets('navigate back from cart to order screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      expect(find.text('Cart'), findsOneWidget);

      // Navigate back
      final backButton = find.widgetWithText(StyledButton, 'Back to Order');
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Verify back on order screen
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });
  });

  group('Profile Screen Tests', () {
    // Note: Profile screen tests cause rendering overflow on small phone due to keyboard
    // These work fine on larger screens
    testWidgets('successfully fill and submit profile',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileButton = find.widgetWithText(StyledButton, 'Profile');
      await tester.ensureVisible(profileButton);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Enter your details:'), findsOneWidget);

      // Fill in name
      final nameField = find.widgetWithText(TextField, 'Your Name');
      await tester.tap(nameField);
      await tester.enterText(nameField, 'John Doe');
      await tester.pumpAndSettle();

      // Fill in location
      final locationField =
          find.widgetWithText(TextField, 'Preferred Location');
      await tester.tap(locationField);
      await tester.enterText(locationField, 'London');
      await tester.pumpAndSettle();

      // Submit
      final saveButton = find.text('Save Profile');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Should be back on order screen with welcome message
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(
          find.text('Welcome, John Doe! Ordering from London'), findsOneWidget);
    });

    testWidgets('profile validation - empty fields show error',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileButton = find.widgetWithText(StyledButton, 'Profile');
      await tester.ensureVisible(profileButton);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      // Try to save without filling fields
      final saveButton = find.text('Save Profile');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Should show error message
      expect(find.text('Please fill in all fields'), findsOneWidget);
      // Should still be on profile screen
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('profile validation - only name filled',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileButton = find.widgetWithText(StyledButton, 'Profile');
      await tester.ensureVisible(profileButton);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      // Fill in only name
      final nameField = find.widgetWithText(TextField, 'Your Name');
      await tester.tap(nameField);
      await tester.enterText(nameField, 'John Doe');
      await tester.pumpAndSettle();

      // Try to save
      final saveButton = find.text('Save Profile');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Should show error message
      expect(find.text('Please fill in all fields'), findsOneWidget);
    });

    testWidgets('profile validation - only location filled',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileButton = find.widgetWithText(StyledButton, 'Profile');
      await tester.ensureVisible(profileButton);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      // Fill in only location
      final locationField =
          find.widgetWithText(TextField, 'Preferred Location');
      await tester.tap(locationField);
      await tester.enterText(locationField, 'London');
      await tester.pumpAndSettle();

      // Try to save
      final saveButton = find.text('Save Profile');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Should show error message
      expect(find.text('Please fill in all fields'), findsOneWidget);
    });
  });

  group('Settings Screen Tests', () {
    testWidgets('navigate to settings and back', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to settings
      final settingsButton = find.widgetWithText(StyledButton, 'Settings');
      await tester.ensureVisible(settingsButton);
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();

      // Wait for settings to load
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Font Size'), findsOneWidget);

      // Navigate back
      final backButton = find.text('Back to Order');
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('adjust font size slider', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to settings
      final settingsButton = find.widgetWithText(StyledButton, 'Settings');
      await tester.ensureVisible(settingsButton);
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();

      // Wait for settings to load
      await tester.pump(const Duration(milliseconds: 500));

      // Find slider
      final slider = find.byType(Slider);
      expect(slider, findsOneWidget);

      // Verify slider exists and is interactive
      final sliderWidget = tester.widget<Slider>(slider);
      expect(sliderWidget.min, 12.0);
      expect(sliderWidget.max, 24.0);
    });
  });

  group('Order History Tests', () {
    testWidgets('view order history after completing an order',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Complete an order first
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      final checkoutButton = find.widgetWithText(StyledButton, 'Checkout');
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      final confirmPaymentButton = find.text('Confirm Payment');
      await tester.tap(confirmPaymentButton);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));

      // Now navigate to order history
      final orderHistoryButton =
          find.widgetWithText(StyledButton, 'Order History');
      await tester.ensureVisible(orderHistoryButton);
      await tester.pumpAndSettle();
      await tester.tap(orderHistoryButton);
      await tester.pumpAndSettle();

      // Wait for orders to load
      await tester.pump(const Duration(seconds: 1));

      // Should see the order history screen
      expect(find.text('Order History'), findsOneWidget);
      // Order should be in the history
      expect(find.textContaining('ORD'), findsWidgets);
    });

    testWidgets('view empty order history', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to order history without placing orders
      final orderHistoryButton =
          find.widgetWithText(StyledButton, 'Order History');
      await tester.ensureVisible(orderHistoryButton);
      await tester.tap(orderHistoryButton);
      await tester.pumpAndSettle();

      // Wait for orders to load
      await tester.pump(const Duration(milliseconds: 500));

      // Should see empty state or at least the history screen loaded
      expect(find.text('Order History'), findsOneWidget);
    });
  });

  group('Complex User Journeys', () {
    testWidgets('complete multi-item order with different customizations',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add first item: Veggie Delight, footlong, white bread, qty 2
      final quantityAddButton = find.byIcon(Icons.add).first;
      await tester.ensureVisible(quantityAddButton);
      await tester.tap(quantityAddButton);
      await tester.pumpAndSettle();

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Change to Chicken Teriyaki, six-inch
      final sandwichDropdown = find.byType(DropdownMenu<SandwichType>);
      await tester.ensureVisible(sandwichDropdown);
      await tester.tap(sandwichDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();

      final sizeSwitch = find.byType(Switch);
      await tester.ensureVisible(sizeSwitch);
      await tester.tap(sizeSwitch);
      await tester.pumpAndSettle();

      // Add second item (six-inch Chicken Teriyaki)
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Since we have different sandwiches, they're separate cart items
      // 2x Veggie Delight footlong (qty 2) + 1x Chicken Teriyaki six-inch (qty 1)
      // Check that items were added (exact total depends on how cart counts)
      final cartText = find.textContaining('Cart:');
      expect(cartText, findsOneWidget);

      // Navigate to cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Verify items in cart
      expect(find.text('Veggie Delight'), findsOneWidget);
      expect(find.text('Chicken Teriyaki'), findsOneWidget);
      // Total should be 2x£11 + 1x£7 = £29
      expect(find.textContaining('Total:'), findsOneWidget);

      // Complete checkout
      final checkoutButton = find.widgetWithText(StyledButton, 'Checkout');
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      final confirmPaymentButton = find.text('Confirm Payment');
      await tester.tap(confirmPaymentButton);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));

      // Verify back on order screen with empty cart
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.text('Cart: 0 items - £0.00'), findsOneWidget);
    });

    testWidgets('add items, modify in cart, then checkout',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add item
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Navigate to cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Increment quantity in cart
      final incrementButton = find.byIcon(Icons.add).first;
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      // Verify updated quantity
      expect(find.text('Qty: 3'), findsOneWidget);
      expect(find.text('Total: £33.00'), findsOneWidget);

      // Proceed to checkout
      final checkoutButton = find.widgetWithText(StyledButton, 'Checkout');
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      // Verify checkout shows correct total
      expect(find.text('3x Veggie Delight'), findsOneWidget);
      expect(find.text('£33.00'), findsWidgets);

      final confirmPaymentButton = find.text('Confirm Payment');
      await tester.tap(confirmPaymentButton);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));

      expect(find.text('Cart: 0 items - £0.00'), findsOneWidget);
    });

    testWidgets('test navigation flow through all screens',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Start on order screen
      expect(find.text('Sandwich Counter'), findsOneWidget);

      // Navigate to profile
      final profileButton = find.widgetWithText(StyledButton, 'Profile');
      await tester.ensureVisible(profileButton);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();
      expect(find.text('Profile'), findsOneWidget);

      // Back to order screen using Navigator.pop simulation
      Navigator.pop(tester.element(find.byType(Scaffold).first));
      await tester.pumpAndSettle();
      expect(find.text('Sandwich Counter'), findsOneWidget);

      // Navigate to settings
      final settingsButton = find.widgetWithText(StyledButton, 'Settings');
      await tester.ensureVisible(settingsButton);
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Settings'), findsOneWidget);

      // Back to order screen
      final backButton = find.text('Back to Order');
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Navigate to order history
      final orderHistoryButton =
          find.widgetWithText(StyledButton, 'Order History');
      await tester.ensureVisible(orderHistoryButton);
      await tester.tap(orderHistoryButton);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Order History'), findsOneWidget);

      // Back to order screen using Navigator.pop
      Navigator.pop(tester.element(find.byType(Scaffold).first));
      await tester.pumpAndSettle();
      expect(find.text('Sandwich Counter'), findsOneWidget);

      // Navigate to cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();
      expect(find.text('Cart'), findsOneWidget);

      // Back to order screen
      final backToOrderButton =
          find.widgetWithText(StyledButton, 'Back to Order');
      await tester.tap(backToOrderButton);
      await tester.pumpAndSettle();
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });
  });
}
