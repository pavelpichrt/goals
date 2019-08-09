import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:goals/tasks/add-task-button.dart';
import 'package:goals/tasks/task-item.dart';
import 'package:intl/intl.dart';
import 'package:goals/tasks/task-view.dart';

class TaskList extends StatefulWidget {
  @override
  createState() => new ToDoListState();
}

class ToDoListState extends State<TaskList> {
  List<TaskItem> _taskItems = [];

  void _addTaskItem(TaskItem task) {
    setState(() => _taskItems.add(task));
  }

  void _removeTaskItem(int index) {
    setState(() => _taskItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TaskItem todo = _taskItems[index];

        return AlertDialog(
          title: Text('Mark "${todo.text}" as done?'),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Mark as DONE'),
              onPressed: () {
                _removeTaskItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskList() {
    _taskItems.sort((task1, task2) => task1.dueDate.compareTo(task2.dueDate));

    return new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        if (index < _taskItems.length) {
          return _buildTaskItem(_taskItems[index], index);
        }
      },
    );
  }

  Widget _buildTaskItem(TaskItem task, int index) {
    final String formattedDate =
        DateFormat('dd/MM/y HH:mm').format(task.dueDate);

    return Container(
      child: GestureDetector(
        onTap: () => _pushEditToDoScreen(index),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: () => _promptRemoveTodoItem(index),
          ),
          title:  Text(task.text),
          subtitle: Text('Due: $formattedDate'),
        ),
      ),
      decoration: BoxDecoration(
        border: const Border(bottom: BorderSide(color: Colors.black12)),
      ),
    );
  }

  void _pushEditToDoScreen(index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TaskView(
            title: 'Edit task',
            task: _taskItems[index],
            onSubmitted: () => null,
          );
        } 
      ),
    );
  }

  void _pushAddToDoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final TaskItem newTask = TaskItem('', DateTime.now());

          return TaskView(
            title: 'Add task',
            task: newTask,
            onSubmitted: () => _addTaskItem(newTask),
          );
        } 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.grey),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('item $index'),
            );
          },
        ),
      ),
      appBar: AppBar(title: Text('Tasks')),
      body: _buildTaskList(),
      floatingActionButton: new AddTaskButton(
        onPressed: _pushAddToDoScreen,
      ),
    );
  }
}
