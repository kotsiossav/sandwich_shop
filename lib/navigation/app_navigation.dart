import 'package:flutter/material.dart';

/// High-level destinations that appear in the app-wide navigation.
enum AppDestination {
  order,
  cart,
  checkout,
  profile,
  about,
}

/// Model describing a single navigation item for the Drawer / nav panel.
class NavigationItem {
  final AppDestination destination;
  final String label;
  final IconData icon;
  final String routeName;

  const NavigationItem({
    required this.destination,
    required this.label,
    required this.icon,
    required this.routeName,
  });
}

/// Central list of navigation items used by the Drawer / responsive navigation.
///
/// Route names are defined here; they should match the routes configured
/// in MaterialApp.
const List<NavigationItem> kNavigationItems = [
  NavigationItem(
    destination: AppDestination.order,
    label: 'Order',
    icon: Icons.restaurant_menu,
    routeName: '/order',
  ),
  NavigationItem(
    destination: AppDestination.cart,
    label: 'Cart',
    icon: Icons.shopping_cart,
    routeName: '/cart',
  ),
  NavigationItem(
    destination: AppDestination.checkout,
    label: 'Checkout',
    icon: Icons.payment,
    routeName: '/checkout',
  ),
  NavigationItem(
    destination: AppDestination.profile,
    label: 'Profile',
    icon: Icons.person,
    routeName: '/profile',
  ),
  NavigationItem(
    destination: AppDestination.about,
    label: 'About',
    icon: Icons.info,
    routeName: '/about',
  ),
];
