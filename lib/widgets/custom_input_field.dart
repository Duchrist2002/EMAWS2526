import 'package:flutter/material.dart';
import '../core/theme.dart';

/// Wiederverwendbares Custom Input Field Widget
/// Mit Schatten-Effekt und Icon-Support wie im UI-Design
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whiteInput,
        borderRadius: BorderRadius.circular(30),
        // Weicher Schatten wie im Design
        boxShadow: AppTheme.inputShadow,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          color: AppTheme.darkText,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppTheme.darkText.withOpacity(0.6),
                )
              : null,
          // Entfernt Standard-Border, da wir Container-Styling nutzen
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
            borderSide: const BorderSide(
              color: AppTheme.oliveGreen,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppTheme.whiteInput,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}
