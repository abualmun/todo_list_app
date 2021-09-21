import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:todo_list/main.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/bloc/tasks_events.dart';
import 'package:todo_list/bloc/tasks_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(TaskState initialState) : super(initialState) {
    add(CallDatabase());
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is CallDatabase) {
      await databaseStart();
      state.mainList = await refreshTasks();
      add(RefreshDatabase());
    } else if (event is RefreshDatabase) {
      yield TaskState()..mainList = state.mainList;
    } else if (event is CallAddTask) {
      await insertToDatabase(event.task);
      state.mainList = await refreshTasks();
      add(RefreshDatabase());
    } else if (event is CallUpdateTask) {
      await updateTask(event.task);
      state.mainList = await refreshTasks();
      add(RefreshDatabase());
    } else if (event is CallDeleteTask) {
      await deleteTask(event.task);
      state.mainList = await refreshTasks();
      add(RefreshDatabase());
    } 
  }
}

Future<List<Task>> refreshTasks() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('tasks');

  TaskState().mainList = List.generate(maps.length, (i) {
    return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isDone: (maps[i]['isDone'] == 1) ? true : false,
        note: maps[i]['note']);
  });

  return List.generate(maps.length, (i) {
    return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isDone: (maps[i]['isDone'] == 1) ? true : false,
        note: maps[i]['note']);
  });
}

class Task {
  final int id;
  final String title;
  final String note;
  bool isDone = false;

  Task({this.id, this.title, this.note, this.isDone});

  Map<String, Object> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'note': this.note,
      'isDone': this.isDone,
    };
  }

  String toString() {
    return 'Task {id: $id ,Title: $title /*,isDone: $isDone ,Note: $note}';
  }
}

Future<Database> database;

Future<void> databaseStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(join(await getDatabasesPath(), 'task_database.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE tasks(id INTEGER  PRIMARY KEY AUTOINCREAMENT,title TEXT , isDone BOOL , note TEXT)');
  }, version: 1);
}

Future<void> insertToDatabase(Task task) async {
  final db = await database;
  await db.insert('tasks', task.toMap());
}

Future<void> updateTask(Task task) async {
  final db = await database;
  await db.update(
    'tasks',
    task.toMap(),
    where: 'id = ?',
    whereArgs: [task.id],
  );
}

Future<void> deleteTask(Task task) async {
  final db = await database;
  await db.delete(
    'tasks',
    where: 'id = ?',
    whereArgs: [task.id],
  );
}
