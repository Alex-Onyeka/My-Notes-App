import 'package:flutter/material.dart';
import 'package:mynotes/services/fire_store_service.dart';
import 'package:mynotes/themes/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _lightMode = lightMode;
  final ThemeData _darkMode = darkMode;

  late bool isDarkMode;

  late ThemeData mainTheme;
  ThemeProvider() {
    mainTheme = _lightMode;
    isDarkMode = false;
    setTheme();
  }

  FireStoreService fireStoreService = FireStoreService();
  void setTheme() async {
    final userDoc =
        await fireStoreService.getCurrentUserDoc();
    var userData = userDoc!.data();
    bool userIsDarkTheme = userData!['is_dark'];

    if (userIsDarkTheme == false) {
      mainTheme = _lightMode;
      isDarkMode = false;
    } else {
      mainTheme = _darkMode;
      isDarkMode = true;
    }
    notifyListeners();
  }

  void changeTheme() async {
    if (mainTheme == _lightMode) {
      mainTheme = _darkMode;
      isDarkMode = true;
    } else {
      mainTheme = _lightMode;
      isDarkMode = false;
    }

    // Update Users IsDark Mode
    final userDoc =
        await fireStoreService.getCurrentUserDoc();
    fireStoreService.userDb.doc(userDoc!.id).update({
      'is_dark': isDarkMode,
    });
    notifyListeners();
  }
}
