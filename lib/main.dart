import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/drawer.dart';
import 'package:todo_list/popup/add_task_page.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/bloc/tasks_events.dart';
import 'package:todo_list/bloc/tasks_state.dart';
import 'package:emojis/emojis.dart';
import 'package:todo_list/popup/task_options.dart';

main() {
  runApp(BlocProvider(
    create: (context) => TaskBloc(TaskState()),
    child: MaterialApp(home: HomePage()),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wryyyyy!!"),
      ),
      drawer: listsMenu(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.ac_unit_outlined),onPressed: addTaskPage(context),),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return ListView.builder(itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(state.mainList[index].title),
                subtitle: Text(state.mainList[index].note),
                trailing: Checkbox(
                  value: state.mainList[index].isDone,
                  onChanged: (value) {
                    value = !value;
                    state.mainList[index].isDone = value;
                    BlocProvider.of<TaskBloc>(context).add(CallUpdateTask(state.mainList[index]));
                  },
                ),
                tileColor: Colors.black12,
                onLongPress: taskOptions(context, state.mainList[index]),
              ),
            );
          });
        },
      ),
    );
  }
}
