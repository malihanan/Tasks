import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'colors.dart';

class Task {
  int id;
  String title;
  int parts;
  int completedParts;
  Color color;

  Task() {
    this.id = 0;
    this.title = '';
    this.parts = 1;
    this.completedParts = 0;
    this.color = CustomColors.pink;
  }

  Task.fromValues(int id, String title, int parts, Color color) {
    this.id = id;
    this.title = title;
    this.parts = parts;
    this.completedParts = 0;
    this.color = color;
  }

  factory Task.fromMap(Map<String, dynamic> parsedJson) {
    Task task = Task.fromValues(
      parsedJson['id'],
      parsedJson['title'],
      parsedJson['parts'],
      parsedJson['color'],
    );
    task.completedParts = parsedJson['completedParts'];
    return task;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "parts": parts,
      "color": color,
      "completedParts": completedParts,
    };
  }

  Task taskFromJson(String str) {
    final jsonData = json.decode(str);
    return Task.fromMap(jsonData);
  }

  String taskToString(Task task) {
    final dyn = task.toMap();
    return json.encode(dyn);
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

  ReminderTask.fromValues(
      int id, String title, int parts, Color color, DateTime date)
      : this.date = date,
        super.fromValues(id, title, parts, color);
}
