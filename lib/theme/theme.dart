import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF2E63A8);
  static const Color _secondaryColor = Color(0xFF79D9AC);
  static const Color _lightScaffoldBackground = Color(0xFFC5E2EF);
  static const Color _darkScaffoldBackground = Color(0xFF1F2F3D);
  static const Color _darkSurface = Color(0xFF263D52);

  // Light Theme
  static final ThemeData lightTheme =
      ThemeData.from(
        colorScheme: ColorScheme(
          brightness: Brightness.light,

          primary: _primaryColor,
          onPrimary: Colors.white,

          secondary: _secondaryColor,
          onSecondary: Colors.white,

          surface: Colors.white,
          onSurface: Colors.black87,

          error: Colors.redAccent,
          onError: Colors.white,
        ),
      ).copyWith(
        scaffoldBackgroundColor: _lightScaffoldBackground,

        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _secondaryColor,
          foregroundColor: Colors.white,
        ),
      );

  // Dark Theme
  static final ThemeData darkTheme =
      ThemeData.from(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,

          primary: _primaryColor,
          onPrimary: Colors.white,

          secondary: _secondaryColor,
          onSecondary: Colors.white,

          surface: _darkSurface,
          onSurface: Colors.white70,

          error: Colors.redAccent,
          onError: Colors.white,
        ),
      ).copyWith(
        scaffoldBackgroundColor: _darkScaffoldBackground,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: _darkSurface,
          foregroundColor: Colors.white,
        ),
        sliderTheme: const SliderThemeData(activeTrackColor: _secondaryColor),
      );
}
