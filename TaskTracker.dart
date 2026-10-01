import 'Task.dart';
import 'TaskPriority.dart';

class Tasktracker {
  List<Task> tasks;

  Tasktracker() : tasks = [];

  bool addTask({
    required String title,
    required String subject,
    TaskPriority priority = TaskPriority.medium,
    String? description,
    bool isCompleted = false,
  }) {
    try {
      Task newTask = Task(title, subject, priority, description, isCompleted);
      tasks.add(newTask);
    } catch (e) {
      return false;
    }
    return true;
  }

  populateSampleTasks() {
    addTask(
      title: "Buy groceries",
      subject: "Personal",
      priority: TaskPriority.medium,
      description: "Milk, Eggs, Bread",
      isCompleted: true
    );
    addTask(
      title: "Finish project report",
      subject: "Work",
      priority: TaskPriority.high,
      description: "Due by end of the week",
    );
    addTask(
      title: "Call plumber",
      subject: "Home Maintenance",
      priority: TaskPriority.low,
    );
  }

  viewTasks() {
    if (tasks.isEmpty) {
      print("\nNo tasks available.");
      return;
    }
  
    for (int i = 0; i < tasks.length; i++) {
      Task task = tasks[i];
      String status = task.isCompleted ? "[✓]" : "[ ]";
      print("$status ${i + 1}. ${task.title}\n    Subject: ${task.subject}\n    Task Priority: ${task.priority.stringValue}${task.description != null ? "\n    Description: ${task.description}" : ""}\n");
    }
  }

  viewSortedTasks() {
    if (tasks.isEmpty) {
      print("\nNo tasks available.");
      return;
    }

    tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    int count = 0;
    
    List<Task> inCompleteTasks = tasks.where((t) => t.isCompleted == false).toList();
    for (Task task in inCompleteTasks) {
      print("[ ] ${count + 1}. ${task.title}\n    Subject: ${task.subject}\n    Task Priority: ${task.priority.stringValue}${task.description != null ? "\n    Description: ${task.description}" : ""}\n");
      count++;
    }

    List<Task> completeTasks = tasks.where((t) => t.isCompleted == true).toList();
    for (Task task in completeTasks) {
      print("[✓] ${count + 1}. ${task.title}\n    Subject: ${task.subject}\n    Task Priority: ${task.priority.stringValue}${task.description != null ? "\n    Description: ${task.description}" : ""}\n");
      count++;
    }
  }

  bool markTaskAsCompleted(int taskNumber) {
    if (tasks[taskNumber - 1].isCompleted) return false;
    tasks[taskNumber - 1].isCompleted = true;
    return true;
  }

  int getIncompleteTaskCount() {
    return tasks.where((t) => t.isCompleted == false).length;
  }
}
