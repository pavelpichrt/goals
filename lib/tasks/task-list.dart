import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:goals/tasks/add-task-button.dart';
import 'package:goals/tasks/task-item.dart';
import 'package:intl/intl.dart';
import 'package:goals/tasks/task-view.dart';
import 'package:goals/database/task-item-provider.dart';

class TaskList extends StatefulWidget {
  final List<TaskItem> dbTasks;
  final TaskItemProvider taskProvider;

  @override
  createState() => TaskListState(dbTasks, taskProvider);

  TaskList(this.dbTasks, this.taskProvider);
}

class TaskListState extends State<TaskList> {
  List<TaskItem> _taskItems = [];
  List<TaskItem> dbTasks;
  TaskItemProvider taskProvider;

  TaskListState(this.dbTasks, this.taskProvider);

  @override
  initState() {
    super.initState();

    setState(() {
      _taskItems = dbTasks;
    });
  }

  Future<void> _addTaskItem(TaskItem task) async {
    await taskProvider.insertTask(task);

    setState(() => _taskItems.add(task));
  }

  Future<void> _editTaskItem(TaskItem task) async {
    await taskProvider.updateTask(task);
  }

  Future<void> _removeTaskItem(int index) async {
    final TaskItem task = _taskItems[index];

    if (task.id != null) {
      await taskProvider.deleteTask(task.id);
    }

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

    return ListView.builder(
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
          title: Text(task.text),
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
      MaterialPageRoute(builder: (context) {
        final TaskItem task = _taskItems[index];

        return TaskView(
          title: 'Edit task',
          task: task,
          onSubmitted: () => _editTaskItem(task),
        );
      }),
    );
  }

  void _pushAddToDoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        final TaskItem newTask = TaskItem('', DateTime.now());

        return TaskView(
          title: 'Add task',
          task: newTask,
          onSubmitted: () => _addTaskItem(newTask),
        );
      }),
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

class TaskListLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
