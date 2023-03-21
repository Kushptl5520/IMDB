import 'package:flutter/material.dart';

const Color mColorAccent = Color(0xffe01f25);
const Color mColorWhite = Colors.white;
const Color mColorBlack = Colors.black;
const Color mColorDivider = Colors.black12;
const Color mColorTransparent = Colors.transparent;

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class ColorConst {


  static const white = Color(0xffffffff);
  static const black = Colors.black;
  static const black12 = Colors.black12;

  static const lightGrey = Color(0xccffffff);
  static const darkgray = Color(0xFF6a6a6a);
  static const transparent = Colors.transparent;
  static const coral = Color(0xFFe20e0e);
  static const lightBlue = Color(0xFF96aad2)  ;
  static const theme = Color(0XFF244da0);
  static const lightblack = Colors.black38;
  static const shinegreen = Color(0XFF50a49b);
  static const light = Color(0xFFf5f5f5);
  static const key = Color(0xFF808080);
  static const value = Color(0xff333333);


}
