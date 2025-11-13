import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];
  final PricingRepository _pricing;

  Cart({PricingRepository? pricing})
      : _pricing = pricing ?? PricingRepository();

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  bool get isEmpty => _items.isEmpty;

  int get totalQuantity =>
      _items.fold<int>(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold<double>(
        0.0,
        (sum, item) =>
            sum +
            _pricing.calculatePrice(
              quantity: item.quantity,
              isFootlong: item.sandwich.isFootlong,
            ),
      );

  void add(Sandwich sandwich, {int quantity = 1}) {
    if (quantity <= 0) return;
    final idx = _indexOf(sandwich);
    if (idx >= 0) {
      final current = _items[idx];
      _items[idx] = current.copyWith(quantity: current.quantity + quantity);
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
    notifyListeners();
  }

  void remove(Sandwich sandwich, {int quantity = 1}) {
    if (quantity <= 0) return;
    final idx = _indexOf(sandwich);
    if (idx < 0) return;

    final current = _items[idx];
    final newQty = current.quantity - quantity;
    if (newQty > 0) {
      _items[idx] = current.copyWith(quantity: newQty);
    } else {
      _items.removeAt(idx);
    }
    notifyListeners();
  }

  void removeItem(Sandwich sandwich) {
    final idx = _indexOf(sandwich);
    if (idx >= 0) {
      _items.removeAt(idx);
      notifyListeners();
    }
  }

  void setQuantity(Sandwich sandwich, int quantity) {
    if (quantity <= 0) {
      removeItem(sandwich);
      return;
    }
    final idx = _indexOf(sandwich);
    if (idx >= 0) {
      _items[idx] = _items[idx].copyWith(quantity: quantity);
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
    notifyListeners();
  }

  bool contains(Sandwich sandwich) => _indexOf(sandwich) >= 0;

  void clear() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }

  int _indexOf(Sandwich sandwich) {
    for (var i = 0; i < _items.length; i++) {
      if (_sameSandwich(_items[i].sandwich, sandwich)) return i;
    }
    return -1;
  }

  bool _sameSandwich(Sandwich a, Sandwich b) {
    return a.type == b.type &&
        a.isFootlong == b.isFootlong &&
        a.breadType == b.breadType;
  }
}

class CartItem {
  final Sandwich sandwich;
  final int quantity;

  const CartItem({required this.sandwich, required this.quantity})
      : assert(quantity > 0);

  CartItem copyWith({Sandwich? sandwich, int? quantity}) {
    return CartItem(
      sandwich: sandwich ?? this.sandwich,
      quantity: quantity ?? this.quantity,
    );
  }
}
