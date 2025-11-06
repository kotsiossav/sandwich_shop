class OrderRepository {
  int _quantity = 0;
  final int maxQuantity;

  OrderRepository({required this.maxQuantity});

  int get quantity => _quantity;

  bool get canIncrement => _quantity < maxQuantity;
  bool get canDecrement => _quantity > 0;

  void increment() {
    if (canIncrement) {
      _quantity++;
    }
  }

  void decrement() {
    if (canDecrement) {
      _quantity--;
    }
  }
}

class PricingRepository {
  final double sixInchPrice;
  final double footlongPrice;

  const PricingRepository({
    this.sixInchPrice = 7.0, // £7 for six-inch
    this.footlongPrice = 11.0, // £11 for footlong
  });

  double unitPrice({required bool isFootlong}) =>
      isFootlong ? footlongPrice : sixInchPrice;

  double total({
    required int quantity,
    required bool isFootlong,
  }) {
    if (quantity <= 0) return 0.0;
    return unitPrice(isFootlong: isFootlong) * quantity;
  }
}
