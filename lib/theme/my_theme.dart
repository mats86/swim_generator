import 'package:flutter/material.dart';

class MyThemeData {
  final Brightness brightness;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final AppBarTheme appBarTheme;
  final IconThemeData iconTheme;
  final Color inversePrimary;

  MyThemeData({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
    required this.appBarTheme,
    required this.iconTheme,
    required this.inversePrimary,
  });

  ThemeData get themeData {
    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: appBarTheme,
      iconTheme: iconTheme,
    );
  }
}
