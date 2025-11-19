import 'package:flutter/material.dart';
import 'package:sandwich_shop/navigation/app_navigation.dart';
import 'package:sandwich_shop/navigation/app_navigation_drawer.dart';

/// Shared scaffold that provides:
/// - AppBar with a title
/// - App-wide navigation (Drawer on small screens, side-nav on large)
/// - Slot for page-specific body content
class AppScaffold extends StatelessWidget {
  final String title;
  final AppDestination currentDestination;
  final Widget body;

  const AppScaffold({
    super.key,
    required this.title,
    required this.currentDestination,
    required this.body,
  });

  void _handleDestinationSelected(
    BuildContext context,
    NavigationItem item,
  ) {
    // Close drawer if open
    Navigator.of(context).maybePop();

    // If already on this route, do nothing
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == item.routeName) {
      return;
    }

    // Replace current route with the selected one
    Navigator.of(context).pushReplacementNamed(item.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const double breakpoint = 600; // simple responsive breakpoint

    if (width < breakpoint) {
      // Small screen: normal Scaffold + Drawer
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: AppNavigationDrawer(
          currentDestination: currentDestination,
          onDestinationSelected: (item) =>
              _handleDestinationSelected(context, item),
        ),
        body: body,
      );
    } else {
      // Large screen: side navigation always visible
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Row(
          children: [
            SizedBox(
              width: 250,
              child: Drawer(
                elevation: 0,
                child: AppNavigationDrawer(
                  currentDestination: currentDestination,
                  onDestinationSelected: (item) =>
                      _handleDestinationSelected(context, item),
                ),
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      );
    }
  }
}
