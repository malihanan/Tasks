import 'package:flutter/material.dart';

class CustomColors {
  static const Color darkBlue = Color.fromRGBO(45, 41, 66, 1);
  static const Color pink = Color.fromRGBO(243, 210, 230, 1);
  static const Color purple = Color.fromRGBO(173, 194, 238, 1);
  static const Color blue = Color.fromRGBO(174, 224, 237, 1);
  static const Color yellow = Color.fromRGBO(251, 216, 127, 1);
  static const Color teal = Color.fromRGBO(176, 242, 180, 1);

  static String colorToString(Color color) {
    if (color == CustomColors.pink)
      return "PINK";
    else if (color == CustomColors.purple)
      return "PURPLE";
    else if (color == CustomColors.blue)
      return "BLUE";
    else if (color == CustomColors.teal)
      return "TEAL";
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
    else if (color == "TEAL")
      return CustomColors.teal;
    else if (color == "YELLOW")
      return CustomColors.yellow;
    else
      return null;
  }
}
