import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:goals/tasks/task-form.dart';
import 'package:flutter/foundation.dart';
import 'package:goals/tasks/task-item.dart';

class TaskView extends StatelessWidget {
  final Function onSubmitted;
  final String title;
  final TaskItem task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TaskForm(
            task: task,
            onSubmitted: onSubmitted,
          ),
        ),
      ),
    );
  }

  TaskView({@required this.onSubmitted, @required this.title, @required this.task});
}
