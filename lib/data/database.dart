
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_with_getx/data/db_fields.dart';

import '../model/to_do_model.dart';

class DbHelper{
  DbHelper._init();
  static final DbHelper instance = DbHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(DBFields.databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  FutureOr<void> _createDB(Database db, int version) async{
    await db.execute('''
    CREATE TABLE ${DBFields.tableName}(
    ${DBFields.columnId} integer primary key autoincrement,
    ${DBFields.columnTitle} text not null,
    ${DBFields.columnDescription} text not null,
    ${DBFields.columnCreateDate} text not null,
    ${DBFields.columnUpdateDate} text not null ,
    ${DBFields.columnDeleteStatus} integer not null)
    ''');
  }

  Future<int> insertTask(Todo todo) async{
    final db = await instance.database;
    return await db.insert(DBFields.tableName,todo.toJson());
  }

  Future<List<Todo>> getAllTodoList() async{
    final db = await instance.database;
    final result = await db.query(DBFields.tableName);
    return result.map((e) => Todo.fromJson(e)).toList();
  }


  Future<void> deleteTask(int id) async{
      final db = await instance.database;
      await db.delete(DBFields.tableName,where: "${DBFields.columnId} = ?",whereArgs: [id]).then((value){
        Fluttertoast.showToast(msg: "Task Deleted Successfully");
      });
  }


  Future<bool> updateTask(Todo todo) async{
    final db = await instance.database;
    db.update(DBFields.tableName,todo.toJson(),where: "${DBFields.columnId} = ?",whereArgs: [todo.id]).then((value){
      Fluttertoast.showToast(msg: "Item Updated Successfully.");
      return true;
    });

    return false;
  }

}