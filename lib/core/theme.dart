import 'package:flutter/material.dart';

/// UniBudget App Theme & Colors
/// Extrahiert aus dem UI-Design (ema-login.JPG)
class AppTheme {
  // Primäre Farbpalette aus dem Design
  static const Color peachBackground =
      Color(0xFFFFBFA4); // Pfirsich-Hintergrund
  static const Color oliveGreen = Color(0xFF728C3C); // Olivgrün für Buttons
  static const Color darkGreen = Color(0xFF5F7E3F); // Dunkelgrün für Headlines
  static const Color whiteInput = Color(0xFFFFFFFF); // Weiß für Input-Felder
  static const Color darkText = Color(0xFF333333); // Dunkelgrau für Text
  static const Color shadowColor = Color(0x33000000); // Sanfter Schatten

  // ThemeData für die gesamte App
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: oliveGreen,
      scaffoldBackgroundColor: peachBackground,
      fontFamily: 'Roboto',

      // Text Theme
      textTheme: const TextTheme(
        // "Login here" - Große Headline
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: darkGreen,
        ),
        // "Welcome back! You've been missed!" - Subtitle
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: darkText,
        ),
        // Button Text
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: whiteInput,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: whiteInput,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 18),

        // Stark abgerundete Ecken wie im Design
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: oliveGreen, width: 2),
        ),

        hintStyle: TextStyle(
          color: darkText.withOpacity(0.5),
          fontSize: 16,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: oliveGreen,
          foregroundColor: whiteInput,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Box Shadow für Input-Felder (wie im Design)
  static List<BoxShadow> get inputShadow => [
        BoxShadow(
          color: shadowColor,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];
}
