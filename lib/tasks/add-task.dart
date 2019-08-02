import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter/foundation.dart';

class AddTask extends StatefulWidget {
  final Function onSubmitted;

  @override
  createState() => AddTaskState(onSubmitted: this.onSubmitted);

  AddTask({@required this.onSubmitted});
}

class AddTaskState extends State<AddTask> {
  final Function onSubmitted;
  DateTime _dueDate = DateTime.now();
  dynamic _markedDateMap;

  AddTaskState({@required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              onSubmitted: (taskText) {
                debugPrint(_dueDate.toString());
                onSubmitted(taskText, _dueDate);
                Navigator.pop(context);
              },
              decoration: const InputDecoration(
                hintText: 'What needs to be done?',
                icon: Icon(Icons.assignment),
                contentPadding: const EdgeInsets.all(16.0),
              ),
            ),
            CalendarCarousel(
              onDayPressed: (DateTime dueDate, List test) {
                debugPrint(dueDate.toString());
                this.setState(() => _dueDate = dueDate);
              },
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
              thisMonthDayBorderColor: Colors.grey,
              weekFormat: false,
              markedDatesMap: _markedDateMap,
              height: 420.0,
              selectedDateTime: _dueDate,
              daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
            ),
          ],
        ),
      ), 
    );
  }
}
