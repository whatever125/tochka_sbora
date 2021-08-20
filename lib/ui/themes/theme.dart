import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: LightColor.primary,
    accentColor: LightColor.accent,
    backgroundColor: LightColor.primary,
    scaffoldBackgroundColor: LightColor.primary,
    canvasColor: LightColor.primary,
    hintColor: LightColor.secondary,
    highlightColor: LightColor.accent,
    focusColor: LightColor.accent,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: LightColor.accent,
      ),
    ),
    iconTheme: IconThemeData(
      color: LightColor.secondary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: LightColor.accent,
      unselectedItemColor: LightColor.secondary,
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}
