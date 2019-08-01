import 'package:flutter/material.dart';
import 'package:goals/todo-list.dart';

void main() => runApp(GoalsApp());

class GoalsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goals',
      home: new ToDoList(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      )
    );
  }
}
