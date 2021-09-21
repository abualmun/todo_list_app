import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/popup/add_task_page.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/bloc/tasks_events.dart';
import 'package:todo_list/bloc/tasks_state.dart';
import 'package:emojis/emojis.dart';
import 'package:todo_list/popup/task_options.dart';

listsMenu() {
  return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
    if (state.mainList == null)
      return Center(
        child: Text('Loading'),
      );
    return ListView.builder(
        itemCount: state.mainList.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return ListTile(
                minVerticalPadding: 32,
                tileColor: Colors.grey[200],
                title: Text('${Emojis.paperclip} Lists'));
          } else {
            return Column(
              children: [
                ListTile(
                  onTap: () {},
                  title: Text(' list $i'),
                ),
                Divider(
                  indent: 4,
                  endIndent: 4,
                )
              ],
            );
          }
        });
  });
}
