import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFE5D8FF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFA77EF9),
    foregroundColor: Colors.black,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF1F133E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF15047C),
    foregroundColor: Colors.white,
  ),
);
