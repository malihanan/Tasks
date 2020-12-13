import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tasks/colors.dart';
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
          "id INTEGER,"
          "title TEXT,"
          "parts INTEGER,"
          "color TEXT,"
          "completedParts INTEGER,"
          "datetime TEXT"
          ")");
    });
  }

  // CREATE

  newTask(Task task) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Task");
    int id = table.first["id"];
    if (id == null) {
      id = 0;
    }
    //insert to the table using the new id
    var raw = 0;
    raw = await db.rawInsert(
      "INSERT Into Task (id,title,parts,color,completedParts,datetime)"
      " VALUES (?,?,?,?,?,?)",
      [
        id,
        task.title,
        task.parts,
        CustomColors.colorToString(task.color),
        task.completedParts,
        task.datetime.toString()
      ],
    );
    return raw;
  }

  // READ

  Future<List<Task>> getAllTasks() async {
    //returns all tasks
    final db = await database;
    var res = await db.query("Task");
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Task>> getTodaysTasks() async {
    //returns today's task
    final db = await database;
    await DBProvider.db.deleteOldTasks();
    var res = await db.query("Task");
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list
        .where((element) => element.datetime.day == DateTime.now().day)
        .toList();
  }

  getTasks(int id) async {
    //get tasks with same id -- not used
    final db = await database;
    var res = await db.query("Task", where: "id = ?", whereArgs: [id]);
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  getTodaysTask(int id) async {
    //get today's task with id -- not used
    final db = await database;
    var res = await db.query("Task",
        where: "id = ? AND date(datetime) == date('now')", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : Null;
  }

  // UPDATE

  updateTask(Task task) async {
    final db = await database;
    var res = await db.rawUpdate(
        "UPDATE Task SET title=?, parts=?, color=? WHERE id=?", [
      task.title,
      task.parts,
      CustomColors.colorToString(task.color),
      task.id
    ]);
    return res;
  }

  updateCompletion(Task task) async {
    final db = await database;
    task.datetime = DateTime.now();
    var res = await db.update("Task", task.toMap(),
        where: "id = ? AND date(datetime) = date('now')", whereArgs: [task.id]);
    return res;
  }

  // DELETE

  deleteTask(int id) async {
    final db = await database;
    db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete from Task");
  }

  deleteOldTasks() async {
    // delete tasks older than 5 days
    final db = await database;
    List<Task> tasks = await DBProvider.db.getAllTasks();

    for (Task task in tasks) {
      var res = await db.query("Task",
          where: "id=? and date(datetime)==date('now')", whereArgs: [task.id]);
      if (res.isEmpty) {
        await db.rawInsert(
          "INSERT Into Task (id,title,parts,color,completedParts,datetime)"
          " VALUES (?,?,?,?,?,?)",
          [
            task.id,
            task.title,
            task.parts,
            CustomColors.colorToString(task.color),
            0,
            DateTime.now().toString(),
          ],
        );
      }
    }
    db.rawDelete(
        "Delete from Task where date(datetime) <= date('now','-5 day')");
  }
}
