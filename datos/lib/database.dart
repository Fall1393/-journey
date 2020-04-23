import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Task{
  String name;
  Task(this.name);
  Map<String, dynamic> toMap(){
    return{
      "name": name,
    };
  }
  Task.fromMap(Map<String, dynamic>map){
    name = map['name'];
  }
}

class TaskDatabase {
  Database _db;
  Future initDB() async {
    _db = await openDatabase(
      'my_db.db',
    version: 1, onCreate: (Database db, int version){
      db.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY, name TEXT NOT NULL);");
     },
    );
    print("DB INITIALIZED");
  }

  insert(Task task) async{
   print(_db.insert("tasks", task.toMap()));
  }
  Future<List<Task>> getAllTasks() async {
    List<Map<String, dynamic>> results = await _db.query("task");
    print("Got:${results.length}");
    return results.map((map) => Task.fromMap(map)).toList();
  }
}