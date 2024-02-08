import 'package:flutter/material.dart';

class Themes {
  static final theme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(35, 33, 38, 1),
    primaryColor: const Color.fromRGBO(125, 125, 125, 1),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Themes.getColors(ColorsValues.ORANGE_COLOR)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR)),
    textTheme: const TextTheme(
      labelMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 16,
      ),
      labelSmall: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white),
      displayLarge: TextStyle(
          fontWeight: FontWeight.w700, color: Colors.white, fontSize: 28),
      displayMedium: TextStyle(
          fontWeight: FontWeight.w800, color: Colors.white, fontSize: 24),
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
          fontWeight: FontWeight.w400, color: Colors.white, fontSize: 12),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    fontFamily: 'Inter',
  );
  static Color getColors(ColorsValues value) {
    final List<Color> colorsList = [
      const Color.fromRGBO(125, 125, 125, 1),
      const Color.fromRGBO(85, 85, 85, 1),
      const Color.fromRGBO(224, 140, 56, 1),

      const Color.fromRGBO(170, 170, 170, 1),
      const Color.fromRGBO(35, 33, 38, 1)

    ];
    return colorsList[value.index];
  }
}


enum ColorsValues {
  DARK_GREY_COLOR,
  LIGHT_GREY_COLOR,
  ORANGE_COLOR,
  LIGHT_TEXT_COLOR,
  BACKGROUND_COLOR
}
