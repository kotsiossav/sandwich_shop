import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TextStyle normalText = TextStyle(
  fontSize: 16,
);

const heading1 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const heading2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

class AppStyles {
  static double _baseFontSize = 16.0;

  static Future<void> loadFontSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _baseFontSize = prefs.getDouble('fontSize') ?? 16.0;
  }

  static Future<void> saveFontSize(double fontSize) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', fontSize);
    _baseFontSize = fontSize;
  }

  static double get baseFontSize => _baseFontSize;

  static TextStyle get normalText => TextStyle(fontSize: _baseFontSize);

  static TextStyle get heading1 => TextStyle(
        fontSize: _baseFontSize + 8,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get heading2 => TextStyle(
        fontSize: _baseFontSize + 4,
        fontWeight: FontWeight.bold,
      );
}
