import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF26A69A); // Teal 400
  static const Color _accentColor = Color(0xFFFFC107);  // Amber 400
  
  static final ThemeData lightTheme = ThemeData.from(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      
      primary: _primaryColor,
      onPrimary: Colors.white,

      secondary: _accentColor,
      onSecondary: Colors.black,

      surface: Colors.white,
      onSurface: Colors.black87,
      
      error: Colors.redAccent,
      onError: Colors.white,
    ),
  ).copyWith(
    scaffoldBackgroundColor: const Color(0xFFF5F5F5), 
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData.from(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      
      primary: _primaryColor,
      onPrimary: Colors.white,

      secondary: _accentColor,
      onSecondary: Colors.black,

      surface: const Color(0xFF1E1E1E),
      onSurface: Colors.white70,
      
      error: Colors.redAccent,
      onError: Colors.white,
    ),
  ).copyWith(
    scaffoldBackgroundColor: const Color(0xFF121212),
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
  );
}