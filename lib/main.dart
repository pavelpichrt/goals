import 'package:flutter/material.dart';
import 'package:goals/tasks/task-list.dart';

void main() => runApp(GoalsApp());

class GoalsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goals',
      home: new TaskList(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      )
    );
  }
}
