class TaskItem {
  String text;
  DateTime dueDate;
  final DateTime createdDate = DateTime.now();

  TaskItem(this.text, this.dueDate);
}
