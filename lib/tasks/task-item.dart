class TaskItem {
  int id;
  String text;
  DateTime dueDate;
  int isDone = 0;
  DateTime createdDate = DateTime.now();

  TaskItem(this.text, this.dueDate);

  Map<String, dynamic> toMap() {
    var map = {
      'text': text,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'isDone': isDone,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  TaskItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    text = map['text'];
    dueDate = DateTime.fromMicrosecondsSinceEpoch(map['dueDate']);
    createdDate = DateTime.fromMicrosecondsSinceEpoch(map['createdDate']);
    isDone = map['isDone'];
  }
}
