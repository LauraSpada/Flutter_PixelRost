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
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFE8DAFF),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIconColor: Colors.black,
    suffixIconColor: Colors.black,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black, 
    selectionColor: Colors.black, 
    selectionHandleColor: Colors.black, 
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black), 
  ),
);
