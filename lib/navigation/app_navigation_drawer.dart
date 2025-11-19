import 'package:flutter/material.dart';
import 'package:sandwich_shop/navigation/app_navigation.dart';

/// Reusable app-wide navigation drawer.
///
/// Shows the list of [kNavigationItems] and notifies when a destination
/// is selected via [onDestinationSelected]. The drawer itself does not
/// perform navigation; callers are responsible for closing the drawer
/// and pushing the appropriate route.
class AppNavigationDrawer extends StatelessWidget {
  final AppDestination currentDestination;
  final ValueChanged<NavigationItem> onDestinationSelected;

  const AppNavigationDrawer({
    super.key,
    required this.currentDestination,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Sandwich Shop',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: kNavigationItems.length,
                itemBuilder: (context, index) {
                  final item = kNavigationItems[index];
                  final bool selected = item.destination == currentDestination;

                  return ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.label),
                    selected: selected,
                    onTap: () => onDestinationSelected(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
