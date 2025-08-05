import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  changeTheme(ThemeMode mode) {
    if (mode == themeMode) return;
    themeMode = mode;

    notifyListeners();
  }
}
