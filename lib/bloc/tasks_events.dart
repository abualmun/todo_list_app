import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/bloc/bloc.dart';

abstract class TaskEvent {}

class CallDatabase extends TaskEvent {}

class RefreshDatabase extends TaskEvent {}

class CallAddTask extends TaskEvent {
  Task task;
  CallAddTask(this.task);
}

class CallUpdateTask extends TaskEvent {
  Task task;
  CallUpdateTask(this.task);
}

class CallDeleteTask extends TaskEvent {
  Task task;
  CallDeleteTask(this.task);
}

