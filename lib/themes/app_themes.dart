import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

class DarkTheme {
  static const Color sidebarBG = Color.fromRGBO(0, 18, 23, 0.8);
  static const Color windowBar = Color(0xFF222222);
  static const mainAppBG = Color(0xFF1C1C1C);

  // Color for the window bar buttons
  static final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFFFFFFFF),
    mouseOver: const Color.fromARGB(255, 60, 60, 60),
    mouseDown: const Color.fromARGB(255, 90, 90, 90),
    iconMouseOver: const Color(0xFFFFFFFF),
    iconMouseDown: const Color(0xFFFFFFFF),
  );

  // Color for the window cross buttons
  static final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFFFFFFFF),
    iconMouseOver: Colors.white,
  );

  // Defualt DarkTheme across the application
  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    primaryColor: Colors.transparent,
    primarySwatch: Colors.grey,
    iconTheme: const IconThemeData().copyWith(color: Colors.white),
    dialogBackgroundColor: const Color(0xFF222222),
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      headline2: const TextStyle(
        color: Colors.white,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        fontSize: 18.0,
        color: Colors.grey[300],
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      bodyText1: TextStyle(
        color: Colors.grey[300],
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      bodyText2: TextStyle(
        color: Colors.grey[300],
        letterSpacing: 0.5,
      ),
      subtitle1: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class LightTheme {
  static const Color sidebarBG = Color.fromRGBO(247, 248, 252, 0.8);
  static const Color windowBar = Color(0xFFf7f8fc);
  static const mainAppBG = Color(0xFFFFFFFF);

  // Color for the window bar buttons
  static final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF000000),
    mouseOver: const Color.fromARGB(255, 220, 220, 220),
    mouseDown: const Color.fromARGB(255, 190, 190, 190),
    iconMouseOver: const Color(0xFF000000),
    iconMouseDown: const Color(0xFF000000),
  );

  // Color for the window cross buttons
  static final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF000000),
    iconMouseOver: Colors.black,
  );
  // Defualt DarkTheme across the application
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    primaryColor: Colors.transparent,
    primarySwatch: Colors.grey,
    iconTheme: const IconThemeData().copyWith(color: Colors.black),
    dialogBackgroundColor: Colors.white,
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      headline2: TextStyle(
        color: Colors.grey[800],
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.grey[800],
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      headline4: TextStyle(
        fontSize: 18.0,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      bodyText1: TextStyle(
        color: Colors.grey[800],
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      bodyText2: TextStyle(
        color: Colors.grey[800],
        letterSpacing: 0.5,
      ),
      subtitle1: TextStyle(
        color: Colors.grey[800],
        fontSize: 12,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

const List<WindowEffect> effects = [
  WindowEffect.aero,
  WindowEffect.transparent,
  WindowEffect.solid,
  WindowEffect.disabled,
];

const Map<WindowEffect, String> effectsStrings = {
  WindowEffect.aero: "Aero",
  WindowEffect.transparent: "Transparent",
  WindowEffect.solid: "Solid",
  WindowEffect.disabled: "Disabled",
};
