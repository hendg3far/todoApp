import 'package:flutter/material.dart';

class AppConfig extends ChangeNotifier {

  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(ThemeMode theme) {
    if (appTheme == theme) {
      return;
    }
    appTheme = theme;
    notifyListeners();
  }
}