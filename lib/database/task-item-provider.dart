import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:goals/tasks/task-item.dart';
import 'package:flutter/material.dart';

class TaskItemProvider {
  Database db;

  Future open() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'goals.db'),
      version: 1,
    );

    await db.execute(
      '''
    CREATE TABLE IF NOT EXISTS tasks(
      id INTEGER PRIMARY KEY autoincrement,
      text TEXT,
      dueDate INTEGER,
      createdDate INTEGER,
      isDone INTEGER
    )
  ''',
    );
  }

  Future<TaskItem> insertTask(TaskItem task) async {
    task.id = await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint(task.id.toString());

    return task;
  }

  Future<TaskItem> getTask(int id) async {
    List<Map> maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return TaskItem.fromMap(maps.first);
    }

    return null;
  }

  Future<int> deleteTask(int id) async {
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTask(TaskItem task) async {
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<List<TaskItem>> getUnfinishedTasks() async {
    List<TaskItem> unfinishedTasks = [];

    List<Map> rawTasks = await db.query(
      'tasks',
      where: 'isDone = ?',
      columns: ['id', 'text', 'dueDate', 'createdDate', 'isDone'],
      whereArgs: [0],
    );

    if (rawTasks.length > 0) {
      for (Map<String, dynamic> rawTask in rawTasks) {
        unfinishedTasks.add(TaskItem.fromMap(rawTask));
      }

      return unfinishedTasks;
    }

    return List();
  }
}
