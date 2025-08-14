import 'package:flutter/material.dart';

class AppTheme {
  // Cores da nossa paleta "Limpeza e Foco"
  static const Color _primaryColor = Color(0xFF26A69A); // Teal 400
  static const Color _accentColor = Color(0xFFFFC107);  // Amber 400
  
  // Tema para o Modo Claro - CORRIGIDO
  static final ThemeData lightTheme = ThemeData.from(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      
      primary: _primaryColor,
      onPrimary: Colors.white,

      secondary: _accentColor,
      onSecondary: Colors.black,

      // 'background' e 'onBackground' foram removidos daqui.
      // Usamos 'surface' como a cor base para os componentes.
      surface: Colors.white,
      onSurface: Colors.black87,
      
      error: Colors.redAccent,
      onError: Colors.white,
    ),
  ).copyWith(
    // A cor de fundo geral do app agora é definida aqui.
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

  // Tema para o Modo Escuro - CORRIGIDO
  static final ThemeData darkTheme = ThemeData.from(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      
      primary: _primaryColor,
      onPrimary: Colors.white,

      secondary: _accentColor,
      onSecondary: Colors.black,

      // 'background' e 'onBackground' foram removidos.
      surface: const Color(0xFF1E1E1E), // Padrão Material para superfícies escuras (cards)
      onSurface: Colors.white70,
      
      error: Colors.redAccent,
      onError: Colors.white,
    ),
  ).copyWith(
    // A cor de fundo geral do app agora é definida aqui.
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