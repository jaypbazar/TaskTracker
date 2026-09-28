enum TaskPriority { low, medium, high }

class Task {
  String title;
  String subject;
  TaskPriority priority;
  String description;
  bool isCompleted;

  Task(this.title, this.subject, this.priority, this.description)
      : isCompleted = false;
}