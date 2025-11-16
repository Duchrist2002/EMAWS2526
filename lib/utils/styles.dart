import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF1A589);
  static const Color primary = Color(0xff538943);
  static const Color buttonText = Colors.white;
  static const Color subtitleText = Color(0xff0a0a0a);
  static const Color fieldFill = Color(0xfffcfefd);
}

class AppTextStyles {
  static const TextStyle loginTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xff5A7C38),
  );

  static const TextStyle loginSubtitle = TextStyle(
    fontSize: 16,
    color: AppColors.subtitleText,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    color: AppColors.buttonText,
  );
}

class AppButtonStyles {
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
  );

  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: Color(0xff538943), // ou une autre couleur
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
  );
}

class AppInputStyles {
  static InputDecoration emailField = InputDecoration(
    labelText: "Email",
    filled: true,
    fillColor: AppColors.fieldFill,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static InputDecoration passwordField = InputDecoration(
    labelText: "Password",
    filled: true,
    fillColor: AppColors.fieldFill,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class AppBoxStyles {
  static BoxDecoration formContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
  );
}
