import 'package:flutter/material.dart';
import 'package:goals/tasks/task-item.dart';
import 'package:goals/tasks/task-list.dart';
import 'package:goals/database/task-item-provider.dart';

void main() => runApp(GoalsApp());

class GoalsApp extends StatelessWidget {
  final TaskItemProvider taskProvider = TaskItemProvider();

  Future<List<TaskItem>> _fetchTasksFromDb() async {
    await taskProvider.open();

    return await taskProvider.getUnfinishedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goals',
      home: FutureBuilder(
        future: _fetchTasksFromDb(),
        builder: (BuildContext context, AsyncSnapshot taskSnap) {
          final bool isLoading = taskSnap.connectionState != ConnectionState.done;

          if (isLoading) {
            return TaskListLoading();
          } else {
            return TaskList(taskSnap.data, taskProvider);
          }
        },
      ),
      theme: ThemeData(
        primarySwatch: Colors.red,
      )
    );
  }
}
