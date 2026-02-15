import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF0D47A1), // Blue from your screenshot
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      cardTheme: CardThemeData( // CardTheme is incorrect
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
      ),
    );
  }
}