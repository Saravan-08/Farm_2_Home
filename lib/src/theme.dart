import 'package:flutter/material.dart';

class AppTheme {
  // Earthy color palette
  static const Color primaryColor = Color(0xFF556B2F); // Dark Olive Green
  static const Color primaryVariantColor = Color(0xFF8FBC8F); // Dark Sea Green
  static const Color secondaryColor = Color(0xFFDAA520); // Goldenrod
  static const Color accentColor = Color(0xFFCD853F); // Peru (Brown)
  static const Color backgroundColor = Color(0xFFF5F5DC); // Beige
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFB00020);
  
  static const Color onPrimaryColor = Colors.white;
  static const Color onSecondaryColor = Colors.black;
  static const Color onBackgroundColor = Colors.black87;
  static const Color onSurfaceColor = Colors.black87;
  static const Color onErrorColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: onPrimaryColor,
      onSecondary: onSecondaryColor,
      onSurface: onSurfaceColor,
      onBackground: onBackgroundColor,
      onError: onErrorColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 4,
      iconTheme: IconThemeData(color: onPrimaryColor),
      titleTextStyle: TextStyle(
        color: onPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: accentColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryColor,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryVariantColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryColor, width: 2.0),
      ),
      labelStyle: const TextStyle(color: primaryColor),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Serif', fontSize: 57, fontWeight: FontWeight.bold, color: onBackgroundColor),
      displayMedium: TextStyle(fontFamily: 'Serif', fontSize: 45, fontWeight: FontWeight.bold, color: onBackgroundColor),
      displaySmall: TextStyle(fontFamily: 'Serif', fontSize: 36, fontWeight: FontWeight.bold, color: onBackgroundColor),
      headlineLarge: TextStyle(fontFamily: 'Sans-serif', fontSize: 32, fontWeight: FontWeight.bold, color: onBackgroundColor),
      headlineMedium: TextStyle(fontFamily: 'Sans-serif', fontSize: 28, fontWeight: FontWeight.bold, color: onBackgroundColor),
      headlineSmall: TextStyle(fontFamily: 'Sans-serif', fontSize: 24, fontWeight: FontWeight.bold, color: onBackgroundColor),
      titleLarge: TextStyle(fontFamily: 'Sans-serif', fontSize: 22, fontWeight: FontWeight.w600, color: onBackgroundColor),
      titleMedium: TextStyle(fontFamily: 'Sans-serif', fontSize: 16, fontWeight: FontWeight.w600, color: onBackgroundColor),
      bodyLarge: TextStyle(fontFamily: 'Sans-serif', fontSize: 16, color: onSurfaceColor),
      bodyMedium: TextStyle(fontFamily: 'Sans-serif', fontSize: 14, color: onSurfaceColor),
      labelLarge: TextStyle(fontFamily: 'Sans-serif', fontSize: 14, fontWeight: FontWeight.bold, color: onPrimaryColor),
    ),
  );
}
