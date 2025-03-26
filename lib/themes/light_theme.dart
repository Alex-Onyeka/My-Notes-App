import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    errorContainer: const Color.fromARGB(
      255,
      255,
      242,
      241,
    ),
    surface: Colors.grey.shade200,
    surfaceContainer: const Color.fromARGB(
      255,
      233,
      233,
      233,
    ),
    brightness: Brightness.light,
    primary: Colors.grey.shade700,
    inversePrimary: const Color.fromARGB(
      255,
      237,
      237,
      237,
    ),
    primaryContainer: const Color.fromARGB(255, 42, 42, 42),
    secondary: Colors.grey.shade600,
    tertiary: Colors.grey.shade500,
    tertiaryContainer: Colors.grey.shade300,
    outline: Colors.grey.shade400,
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(toolbarHeight: 90),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    errorContainer: const Color.fromARGB(255, 54, 43, 42),
    surface: Colors.grey.shade900,
    surfaceContainer: const Color.fromARGB(255, 50, 50, 50),
    brightness: Brightness.dark,
    primary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
    primaryContainer: const Color.fromARGB(
      255,
      197,
      197,
      197,
    ),
    secondary: Colors.grey.shade500,
    tertiary: Colors.grey.shade400,
    tertiaryContainer: Colors.grey.shade800,
    outline: Colors.grey.shade600,
  ),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(toolbarHeight: 90),
);
