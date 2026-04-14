import 'package:flutter/material.dart';

enum AppColorTheme { green, purple, blue }

extension AppColorThemeExtension on AppColorTheme {
  String get storageKey {
    switch (this) {
      case AppColorTheme.green:
        return 'green';
      case AppColorTheme.purple:
        return 'purple';
      case AppColorTheme.blue:
        return 'blue';
    }
  }

  String get displayName {
    switch (this) {
      case AppColorTheme.green:
        return 'Green Theme';
      case AppColorTheme.purple:
        return 'Purple Theme';
      case AppColorTheme.blue:
        return 'Blue Theme';
    }
  }

  Color get seedColor {
    switch (this) {
      case AppColorTheme.green:
        return const Color(0xFF00695C);
      case AppColorTheme.purple:
        return const Color(0xFF701B99);
      case AppColorTheme.blue:
        return const Color(0xFF1976D2);
    }
  }
}

AppColorTheme? appColorThemeFromString(String? value) {
  switch (value) {
    case 'green':
      return AppColorTheme.green;
    case 'purple':
      return AppColorTheme.purple;
    case 'blue':
      return AppColorTheme.blue;
    default:
      return null;
  }
}

ThemeData appThemeData(AppColorTheme theme, Brightness brightness) {
  return ThemeData(
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: theme.seedColor,
      brightness: brightness,
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: theme.seedColor,
        brightness: brightness,
      ).primary,
    ),
  );
}
