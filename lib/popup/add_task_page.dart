import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/tasks_events.dart';
import 'package:todo_list/bloc/tasks_state.dart';

import '../bloc/bloc.dart';
addTaskPage(BuildContext context) {
  var _titleController = TextEditingController();
  var _noteController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add a Task',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              TextField(
                maxLength: 32,
                maxLines: 1,
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
           
              TextField(
                textAlignVertical: TextAlignVertical.top,
                maxLength: 512,
                minLines: 3,
                maxLines: 12,
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'Notes..',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: Text('Add Task'),
                      onPressed: () {
                        BlocProvider.of<TaskBloc>(context)
                            .add(CallAddTask(Task(
                                title: _titleController.text,
                                note: _noteController.text)));
                        _titleController.text = null;
                        _noteController.text = null;
                         Navigator.of(context).pop(false);
                      }),
                  ElevatedButton(
                      child: Text('Cancel'),
                      onPressed: () {
                         Navigator.of(context).pop(false);
    
                       
                        
                      })
                ],
              )
            ],
          ),
        );
      });
}
