import 'package:flutter/material.dart';

class CustomColors {
  static final Color darkBlue = Color.fromRGBO(45, 41, 66, 1);
  static final Color pink = Color.fromRGBO(243, 210, 230, 1);
  static final Color purple = Color.fromRGBO(173, 194, 238, 1);
  static final Color blue = Color.fromRGBO(174, 224, 237, 1);

  static String colorToString(Color color) {
    if (color == CustomColors.pink)
      return "PINK";
    else if (color == CustomColors.purple)
      return "PURPLE";
    else if (color == CustomColors.blue)
      return "BLUE";
    else
      return null;
  }

  static Color stringToColor(String color) {
    if (color == "PINK")
      return CustomColors.pink;
    else if (color == "PURPLE")
      return CustomColors.purple;
    else if (color == "BLUE")
      return CustomColors.blue;
    else
      return null;
  }
}
