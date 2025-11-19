import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/navigation/app_scaffold.dart';
import 'package:sandwich_shop/navigation/app_navigation.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'About',
      currentDestination: AppDestination.about,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Sandwich Shop App\n\nThis is a demo app for ordering sandwiches.',
          style: normalText,
        ),
      ),
    );
  }
}
