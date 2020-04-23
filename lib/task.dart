import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';

class Task {
  String title;
  int parts;
  int completedParts;
  Color color;

  Task() {
    this.title = '';
    this.parts = 1;
    this.completedParts = 0;
    this.color = CustomColors.pink;
  }

  Task.fromValues(String title, int parts, Color color) {
    this.title = title;
    this.parts = parts;
    this.completedParts = 0;
    this.color = color;
  }

  double getCompletionPercentage() {
    return this.completedParts / this.parts;
  }
}

class ReminderTask extends Task {
  DateTime date;

  ReminderTask()
      : this.date = null,
        super();

  ReminderTask.fromValues(String title, int parts, Color color, DateTime date)
      : this.date = date,
        super.fromValues(title, parts, color);
}
