import 'package:flutter/material.dart';

/// Holds the current [ThemeMode] and lets any widget flip it.
///
/// Kept intentionally tiny (a global [ValueNotifier]) — no state-management
/// package needed for a project this size. `MaterialApp` listens to [mode].
class ThemeController {
  ThemeController._();
  static final ThemeController instance = ThemeController._();

  final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);

  bool get isDark => mode.value == ThemeMode.dark;

  void toggle() => mode.value = isDark ? ThemeMode.light : ThemeMode.dark;

  void setDark(bool dark) =>
      mode.value = dark ? ThemeMode.dark : ThemeMode.light;
}
