import 'package:flutter/material.dart';

class CustomColors {
  static final Color darkBlue = Color.fromRGBO(45, 41, 66, 1);
  static final Color pink = Color.fromRGBO(243, 210, 230, 1);
  static final Color purple = Color.fromRGBO(173, 194, 238, 1);
  static final Color blue = Color.fromRGBO(174, 224, 237, 1);
  static final Color green = Color.fromRGBO(165, 214, 157, 1);
  static final Color yellow = Color.fromRGBO(255, 245, 177, 1);
  // static final Color yellow = Color.fromRGBO(255, 245, 157, 1); less dull
  // static final Color green = Color.fromRGBO(155, 215, 154, 1);
  // static final Color yellow = Color.fromRGBO(215, 235, 105, 1); brighter

  static String colorToString(Color color) {
    if (color == CustomColors.pink)
      return "PINK";
    else if (color == CustomColors.purple)
      return "PURPLE";
    else if (color == CustomColors.blue)
      return "BLUE";
    else if (color == CustomColors.green)
      return "GREEN";
    else if (color == CustomColors.yellow)
      return "YELLOW";
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
    else if (color == "GREEN")
      return CustomColors.green;
    else if (color == "YELLOW")
      return CustomColors.yellow;
    else
      return null;
  }
}
