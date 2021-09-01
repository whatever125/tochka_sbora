import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    platform: TargetPlatform.iOS,
    brightness: Brightness.light,
    primaryColor: LightColor.primary,
    accentColor: LightColor.accent,
    backgroundColor: LightColor.primary,
    scaffoldBackgroundColor: LightColor.primary,
    canvasColor: LightColor.primary,
    hintColor: LightColor.textSecondary,
    highlightColor: LightColor.accent,
    focusColor: LightColor.accent,
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: LightColor.primary,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: LightColor.accent,
      ),
    ),
    iconTheme: IconThemeData(
      color: LightColor.textSecondary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: LightColor.accent,
      unselectedItemColor: LightColor.textSecondary,
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(LightColor.accent),
        overlayColor: MaterialStateProperty.all<Color>(Color(0x30e11344)),
      ),
    ),
  );
}
