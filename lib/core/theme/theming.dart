import 'package:flutter/material.dart';
import 'package:evently/core/colors/dark_colors.dart';
import 'package:evently/core/colors/light_colors.dart';
import 'package:evently/core/colors/main_colors.dart';

class AppTheming {
  static MainColors getColors(Brightness brightness) {
    return brightness == Brightness.dark ? DarkColors() : LightColors();
  }

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: LightColors().primary100,
    appBarTheme: AppBarTheme(
      backgroundColor: LightColors().primary100,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: LightColors().primary100,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    textTheme: TextTheme(),
    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: DarkColors().primary100,
    appBarTheme: AppBarTheme(
      backgroundColor: DarkColors().primary100,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: DarkColors().primary100,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    textTheme: TextTheme(),
    brightness: Brightness.dark,
  );
}
