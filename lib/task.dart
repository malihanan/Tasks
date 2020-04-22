import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Task {
  String title;
  int parts;
  int completedParts;
  Color color;

  Task(String title, int parts, int completedParts, Color color) {
    this.title = title;
    this.parts = parts;
    this.completedParts = completedParts;
    this.color = color;
  }

  double getCompletionPercentage() {
    return this.completedParts / this.parts;
  }
}
