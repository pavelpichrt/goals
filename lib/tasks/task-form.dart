import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:goals/tasks/task-item.dart';

class TaskForm extends StatefulWidget {
  final Function onSubmitted;
  final TaskItem task;
  @override

  createState() => TaskFormState(onSubmitted: this.onSubmitted, task: this.task);

  TaskForm({@required this.onSubmitted, @required this.task});
}

class TaskFormState extends State<TaskForm> {
  final Function onSubmitted;
  final TaskItem task;
  final _formKey = GlobalKey<FormState>();
  var _displayDate = TextEditingController();
  var _displayTime = TextEditingController();
  
  TaskFormState({@required this.onSubmitted, @required this.task});
  
  void _updateDateFieldCaptions() {
    _displayDate.text = DateFormat('dd/MM/y').format(task.dueDate);
    _displayTime.text = DateFormat('Hm').format(task.dueDate);
  }

  @override
  initState() {
    super.initState();

    _updateDateFieldCaptions();
  }

  @override
  Widget build(BuildContext context) {
    _updateDateFieldCaptions();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }

              return null;
            },
            initialValue: task.text,
            onSaved: (val) => setState(() => task.text = val),
            decoration: const InputDecoration(
              labelText: 'Task',
              hintText: 'What needs to get done?',
              icon: Icon(Icons.assignment),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      color: Colors.transparent,
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: _displayDate,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            icon: Icon(Icons.date_range),
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),                          
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      onConfirm: (date) {
                        setState(() {
                          task.dueDate = date.add(Duration(
                            hours: task.dueDate.hour,
                            minutes: task.dueDate.minute,
                            seconds: task.dueDate.second,
                          ));
                        });
                      },
                      currentTime: task.dueDate,
                    );
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Container(
                      color: Colors.transparent,
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: _displayTime,
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            icon: Icon(Icons.timer),
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (time) {
                        setState(() {
                          task.dueDate = time;
                        });
                      },
                      currentTime: task.dueDate,
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                final form = _formKey.currentState;

                if (form.validate()) {
                  form.save();
                  onSubmitted();
                  Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
