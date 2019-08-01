import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ToDoList extends StatefulWidget {
  @override
  createState() => new ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  List<String> _todoItems = [];

  void _addToDoItem(String task) {
    setState(() {
      _todoItems.add(task);
    });
  }

  void _removeToDoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                new FlatButton(
                  child: new Text('Mark as DONE'),
                  onPressed: () {
                    _removeToDoItem(index);
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }

  Widget _buildToDoList() {
    return new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildToDoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildToDoItem(String todoText, int index) {
    return new ListTile(
      trailing: new IconButton(
        icon: Icon(Icons.check_circle_outline),
        onPressed: () => _promptRemoveTodoItem(index),
      ),
      title: Text(todoText),
      subtitle: Text('prdel'),
    );
  }

  Widget _pushAddToDoScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task'),
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addToDoItem(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
                hintText: 'Add something, bitch... :D',
                contentPadding: const EdgeInsets.all(16.0)),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      appBar: AppBar(title: Text('ToDo List')),
      body: _buildToDoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddToDoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add),
      ),
    );
  }
}
