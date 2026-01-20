import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFE8DAFF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFAE86C1),
    foregroundColor: Colors.black,
  ),
  dividerTheme: const DividerThemeData(color: Colors.black),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF350D4C),
    foregroundColor: Colors.white,
  ),
  dividerTheme: const DividerThemeData(color: Colors.white),
);
