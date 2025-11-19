import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/about_screen.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      initialRoute: '/order',
      routes: {
        '/order': (context) => const OrderScreen(maxQuantity: 5),
        '/cart': (context) {
          // Temporary: create a fresh Cart when navigating from the drawer.
          final tempCart = Cart();
          return CartScreen(cart: tempCart);
        },
        '/checkout': (context) {
          // Temporary: create a fresh Cart for checkout from the drawer.
          final tempCart = Cart();
          return CheckoutScreen(cart: tempCart);
        },
        '/profile': (context) => const ProfileScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
