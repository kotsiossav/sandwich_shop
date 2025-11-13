import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  late Cart cart;
  late Sandwich veggie;
  late Sandwich chicken;

  setUp(() {
    cart = Cart(pricing: PricingRepository());

    veggie = Sandwich(
      type: SandwichType.veggieDelight,
      isFootlong: false,
      breadType: BreadType.white,
    );

    chicken = Sandwich(
      type: SandwichType.chickenTeriyaki,
      isFootlong: true,
      breadType: BreadType.wheat,
    );
  });

  test('Cart starts empty', () {
    expect(cart.isEmpty, true);
    expect(cart.totalQuantity, 0);
    expect(cart.totalPrice, 0.0);
  });

  test('Add sandwich increases totalQuantity and items', () {
    cart.add(veggie, quantity: 2);
    expect(cart.totalQuantity, 2);
    expect(cart.items.length, 1);
    expect(cart.items.first.sandwich, veggie);
    expect(cart.items.first.quantity, 2);
  });

  test('Adding the same sandwich increases quantity', () {
    cart.add(veggie, quantity: 1);
    cart.add(veggie, quantity: 3);
    expect(cart.items.length, 1);
    expect(cart.items.first.quantity, 4);
  });

  test('Add multiple different sandwiches', () {
    cart.add(veggie, quantity: 1);
    cart.add(chicken, quantity: 2);
    expect(cart.items.length, 2);
    expect(cart.totalQuantity, 3);
  });

  test('Remove decreases quantity or removes item', () {
    cart.add(veggie, quantity: 3);
    cart.remove(veggie, quantity: 1);
    expect(cart.items.first.quantity, 2);

    cart.remove(veggie, quantity: 2);
    expect(cart.items.isEmpty, true);
  });

  test('setQuantity updates quantity or removes item if zero', () {
    cart.add(veggie, quantity: 2);
    cart.setQuantity(veggie, 5);
    expect(cart.items.first.quantity, 5);

    cart.setQuantity(veggie, 0);
    expect(cart.items.isEmpty, true);
  });

  test('clear empties the cart', () {
    cart.add(veggie, quantity: 1);
    cart.add(chicken, quantity: 1);
    cart.clear();
    expect(cart.items.isEmpty, true);
    expect(cart.totalQuantity, 0);
    expect(cart.totalPrice, 0.0);
  });

  test('totalPrice calculates correctly', () {
    cart.add(veggie, quantity: 2); // 2 * 7.0 = 14.0
    cart.add(chicken, quantity: 1); // 1 * 11.0 = 11.0
    expect(cart.totalPrice, 25.0);
  });

  test('contains returns true if sandwich exists', () {
    cart.add(veggie);
    expect(cart.contains(veggie), true);
    expect(cart.contains(chicken), false);
  });
}
