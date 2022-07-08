// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

Map<int, Color> blackSwatchColorMap = {
  50: Color.fromRGBO(32, 32, 32, .1),
  100: Color.fromRGBO(32, 32, 32, .2),
  200: Color.fromRGBO(32, 32, 32, .3),
  300: Color.fromRGBO(32, 32, 32, .4),
  400: Color.fromRGBO(32, 32, 32, .5),
  500: Color.fromRGBO(32, 32, 32, .6),
  600: Color.fromRGBO(32, 32, 32, .7),
  700: Color.fromRGBO(32, 32, 32, .8),
  800: Color.fromRGBO(32, 32, 32, .9),
  900: Color.fromRGBO(32, 32, 32, 1),
};
MaterialColor blackSwatch = MaterialColor(0xFF170707, blackSwatchColorMap);

Map<int, Color> whiteSwatchColorMap = {
  50: Color.fromRGBO(250, 250, 250, .1),
  100: Color.fromRGBO(250, 250, 250, .2),
  200: Color.fromRGBO(250, 250, 250, .3),
  300: Color.fromRGBO(250, 250, 250, .4),
  400: Color.fromRGBO(250, 250, 250, .5),
  500: Color.fromRGBO(250, 250, 250, .6),
  600: Color.fromRGBO(250, 250, 250, .7),
  700: Color.fromRGBO(250, 250, 250, .8),
  800: Color.fromRGBO(250, 250, 250, .9),
  900: Color.fromRGBO(250, 250, 250, 1),
};
// Green color code: 93cd48 and first two characters (FF) are alpha values (transparency)
MaterialColor whiteSwatch = MaterialColor(0xFFF7F7F7, whiteSwatchColorMap);

class MyThemes {
  static final darkTheme = ThemeData(
    primaryColor: Color(0xFF44c2c7),
    brightness: Brightness.dark,
    dividerColor: Colors.black12,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: whiteSwatch,
      brightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: whiteSwatch),
    primaryIconTheme: IconThemeData(color: whiteSwatch),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF44c2c7),
      ),
    ),
  );

  ThemeData getDark() => darkTheme;

  static final lightTheme = ThemeData(
      primaryColor: Color(0xFF44c2c7),
      brightness: Brightness.light,
      dividerColor: Colors.white54,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: blackSwatch,
        brightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: blackSwatch),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.grey),
              backgroundColor: MaterialStateProperty.all(blackSwatch),
              foregroundColor: MaterialStateProperty.all(whiteSwatch))));

  ThemeData getLight() => lightTheme;
}
