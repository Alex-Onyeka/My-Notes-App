import 'package:flutter/material.dart';
import 'package:mynotes/services/fire_store_service.dart';
import 'package:mynotes/themes/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _lightMode = lightMode;
  final ThemeData _darkMode = darkMode;
  FireStoreService fireStoreService = FireStoreService();

  late bool isDarkMode;

  late ThemeData mainTheme;
  ThemeProvider() {
    mainTheme = _lightMode;
    isDarkMode = false;
  }

  void changeTheme() {
    if (mainTheme == _lightMode) {
      mainTheme = _darkMode;
      isDarkMode = true;
    } else {
      mainTheme = _lightMode;
      isDarkMode = false;
    }
    notifyListeners();
  }
}
