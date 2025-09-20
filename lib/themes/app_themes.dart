import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFE8DAFF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF671993),
    foregroundColor: Colors.black,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF7136BE),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF45046A),
    foregroundColor: Colors.white,
  ),
);
