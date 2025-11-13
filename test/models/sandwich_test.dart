import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('name returns display name for each SandwichType', () {
      final expectations = <SandwichType, String>{
        SandwichType.veggieDelight: 'Veggie Delight',
        SandwichType.chickenTeriyaki: 'Chicken Teriyaki',
        SandwichType.tunaMelt: 'Tuna Melt',
        SandwichType.meatballMarinara: 'Meatball Marinara',
      };

      expectations.forEach((type, expectedName) {
        final sixInch = Sandwich(
          type: type,
          isFootlong: false,
          breadType: BreadType.white,
        );
        final footlong = Sandwich(
          type: type,
          isFootlong: true,
          breadType: BreadType.wheat,
        );

        expect(sixInch.name, expectedName);
        expect(footlong.name, expectedName);
      });
    });

    test('image returns correct path for six-inch sandwiches', () {
      final expectations = <SandwichType, String>{
        SandwichType.veggieDelight: 'assets/images/veggieDelight_six_inch.png',
        SandwichType.chickenTeriyaki:
            'assets/images/chickenTeriyaki_six_inch.png',
        SandwichType.tunaMelt: 'assets/images/tunaMelt_six_inch.png',
        SandwichType.meatballMarinara:
            'assets/images/meatballMarinara_six_inch.png',
      };

      expectations.forEach((type, expectedPath) {
        final sandwich = Sandwich(
          type: type,
          isFootlong: false,
          breadType: BreadType.wholemeal,
        );
        expect(sandwich.image, expectedPath);
      });
    });

    test('image returns correct path for footlong sandwiches', () {
      final expectations = <SandwichType, String>{
        SandwichType.veggieDelight: 'assets/images/veggieDelight_footlong.png',
        SandwichType.chickenTeriyaki:
            'assets/images/chickenTeriyaki_footlong.png',
        SandwichType.tunaMelt: 'assets/images/tunaMelt_footlong.png',
        SandwichType.meatballMarinara:
            'assets/images/meatballMarinara_footlong.png',
      };

      expectations.forEach((type, expectedPath) {
        final sandwich = Sandwich(
          type: type,
          isFootlong: true,
          breadType: BreadType.wheat,
        );
        expect(sandwich.image, expectedPath);
      });
    });

    test('breadType is stored and does not affect name/image', () {
      final s1 = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.white,
      );
      final s2 = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.wholemeal,
      );

      expect(s1.breadType, BreadType.white);
      expect(s2.breadType, BreadType.wholemeal);
      expect(s1.name, s2.name);
      expect(s1.image, s2.image);
    });
  });
}
