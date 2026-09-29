import 'Task.dart';
import 'TaskPriority.dart';

class Tasktracker {
  List<Task> tasks;

  Tasktracker() : tasks = [];

  bool addTask({required String title, required String subject, TaskPriority priority = TaskPriority.medium, String? description}) {
    try {
      Task newTask = Task(title, subject, priority, description);
      tasks.add(newTask);
    } catch (e) {
      return false;
    }
    return true;
  }

}