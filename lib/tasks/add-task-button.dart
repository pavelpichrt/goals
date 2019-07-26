import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  AddTaskButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.red,
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              Icons.add, 
              color: Colors.white
            ),
            SizedBox(width: 8.0),
            Text(
              'Add task', 
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
        
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
