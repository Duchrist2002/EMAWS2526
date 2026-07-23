import 'package:flutter/material.dart';

/// UniBudget theme — light and dark, derived from the app's brand palette
/// (peach + olive, extracted from the original UI design).
class AppTheme {
  // ----- Brand colors (light) -----
  static const Color oliveGreen = Color(0xFF728C3C);
  static const Color darkGreen = Color(0xFF5F7E3F);
  static const Color peachBackground = Color(0xFFFFBFA4);
  static const Color accentOrange = Color(0xFFE4711A);
  static const Color whiteInput = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF333333);
  static const Color shadowColor = Color(0x33000000);

  // ----- Dark variants -----
  static const Color darkScaffold = Color(0xFF23201C);
  static const Color darkSurface = Color(0xFF2E2A25);
  static const Color darkOlive = Color(0xFF9BBE5B);
  static const Color darkOnSurface = Color(0xFFECE6DD);

  /// Soft shadow used by input fields and cards.
  static List<BoxShadow> get inputShadow => const [
        BoxShadow(color: shadowColor, blurRadius: 10, offset: Offset(0, 4)),
      ];

  static ThemeData get lightTheme => _build(
        brightness: Brightness.light,
        scaffold: peachBackground,
        surface: whiteInput,
        onSurface: darkText,
        primary: oliveGreen,
      );

  static ThemeData get darkTheme => _build(
        brightness: Brightness.dark,
        scaffold: darkScaffold,
        surface: darkSurface,
        onSurface: darkOnSurface,
        primary: darkOlive,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color scaffold,
    required Color surface,
    required Color onSurface,
    required Color primary,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      secondary: accentOrange,
      onSecondary: Colors.white,
      surface: surface,
      onSurface: onSurface,
      error: const Color(0xFFB3261E),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 36, fontWeight: FontWeight.bold, color: primary),
        bodyLarge: TextStyle(fontSize: 16, color: onSurface),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle:
            TextStyle(color: onSurface.withValues(alpha: 0.5), fontSize: 16),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
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
          borderSide: BorderSide(color: primary, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 3,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
