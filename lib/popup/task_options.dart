import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/bloc/tasks_events.dart';

taskOptions(BuildContext context, Task task) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(task.title),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        task.isDone = !task.isDone;
                        BlocProvider.of<TaskBloc>(context)
                            .add(CallUpdateTask(task));
                            Navigator.of(context).pop(false);
                      },
                      child: Text((task.isDone) ? 'UnMark' : 'Mark as Done')),
                  SizedBox(width: 8),
                  ElevatedButton(onPressed: (){
                        BlocProvider.of<TaskBloc>(context)
                            .add(CallDeleteTask(task));
                            Navigator.of(context).pop(false);
                  }, child: Text('Delete'))
                ],
              )
            ],
          ),
        ));
      });
}
