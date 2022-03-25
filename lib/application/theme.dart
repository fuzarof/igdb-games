import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'Montserrat',
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 145, 71, 255),
      onPrimary: Color.fromARGB(255, 231, 231, 231),
      secondary: Color.fromARGB(255, 70, 70, 70),
      onSecondary: Color.fromARGB(255, 231, 231, 231),
      error: Color.fromARGB(255, 190, 78, 78),
      onError: Color.fromARGB(255, 231, 231, 231),
      background: Color.fromARGB(255, 238, 236, 241),
      onBackground: Color.fromARGB(255, 54, 54, 54),
      surface: Color.fromARGB(255, 255, 255, 255),
      onSurface: Color.fromARGB(255, 71, 71, 71)),
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      color: Color.fromARGB(255, 54, 54, 54),
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 54, 54, 54),
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 54, 54, 54),
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 54, 54, 54),
    ),
  ),
);
