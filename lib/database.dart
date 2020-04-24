import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tasks/task.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TaskDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Task ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "parts INTEGER,"
          "color TEXT,"
          "completedParts INTEGER"
          ")");
    });
  }

  // newTask(Task task) async {
  //   final db = await database;
  //   var res = await db.insert("Task", task.toMap());
  //   return res;
  // }

  newTask(Task task) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Task");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Client (id,title,parts,color,completedParts)"
        " VALUES (?,?,?,?,?)",
        [id, task.title, task.parts, task.color, task.completedParts]);
    return raw;
  }

  getTask(int id) async {
    final db = await database;
    var res = await db.query("Task", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : Null;
  }

  getAllTasks() async {
    final db = await database;
    var res = await db.query("Task");
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  updateTask(Task task) async {
    final db = await database;
    var res = await db
        .update("Task", task.toMap(), where: "id = ?", whereArgs: [task.id]);
    return res;
  }

  deleteTask(int id) async {
    final db = await database;
    db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}
