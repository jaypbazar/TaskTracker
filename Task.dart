import 'TaskPriority.dart';

class Task {
  String title;
  String subject;
  TaskPriority priority;
  String? description;
  bool isCompleted;

  Task(
    this.title,
    this.subject,
    this.priority,
    this.description,
    this.isCompleted,
  );
}
