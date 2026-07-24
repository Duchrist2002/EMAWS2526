import 'package:flutter/material.dart';

// Manage theme mode
class ThemeController {
  ThemeController._();
  static final ThemeController instance = ThemeController._();

  final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);

  bool get isDark => mode.value == ThemeMode.dark;

  void toggle() => mode.value = isDark ? ThemeMode.light : ThemeMode.dark;

  void setDark(bool dark) =>
      mode.value = dark ? ThemeMode.dark : ThemeMode.light;
}
