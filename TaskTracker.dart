import 'Task.dart';
import 'TaskPriority.dart';

class Tasktracker {
  List<Task> tasks;

  Tasktracker() : tasks = [];
  
  List<String> log = [];

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

  displayTask(int index) {
    Task task = tasks[index];
    print("\nTitle: ${task.title}");
    print("Subject: ${task.subject}");
    print("Priority: ${task.priority.stringValue}");
    print("Description: ${task.description != null ? '${task.description}' : 'N/A'}");
    print("isComplete: ${task.isCompleted ? 'Yes' : 'No'}");
  }

  getTaskTitleAtIndex(int index) {
    return tasks[index].title;
  }

  bool editTask({required int index, String? title, String? subject, String? description}) {
    try {
      if (title != null) tasks[index].title = title;
      if (subject != null) tasks[index].subject = subject;
      if (description != null) tasks[index].description = description;
      
      return true;
    } 
    catch (e) {
      return false;
    }
  }

  bool deleteTask(int index) {
    try {
      tasks.removeAt(index);
      return true;
    }
    catch (e){
      return false;
    }
  }

  bool increaseTaskPriority(int index) {
    if (tasks[index].priority == TaskPriority.high) return false;
    tasks[index].priority = TaskPriority.values[tasks[index].priority.index + 1];
    return true;
  }

  bool decreaseTaskPriority(int index) {
    if (tasks[index].priority == TaskPriority.low) return false;
    tasks[index].priority = TaskPriority.values[tasks[index].priority.index - 1];
    return true;
  }

  bool markTaskAsCompleted(int index) {
    if (tasks[index].isCompleted) return false;
    tasks[index].isCompleted = true;
    return true;
  }

  bool searchTasks(String searchTerm) {
    List<Task> matchingTasks = tasks.where((task) =>
        task.title.toLowerCase().contains(searchTerm.toLowerCase()) ||
        task.subject.toLowerCase().contains(searchTerm.toLowerCase()) ||
        task.priority.stringValue.toLowerCase().contains(searchTerm.toLowerCase()) ||
        task.description != null && task.description!.toLowerCase().contains(searchTerm.toLowerCase())).toList();

    if (matchingTasks.isEmpty) return false;

    for (int i = 0; i < matchingTasks.length; i++) {
      Task task = matchingTasks[i];
      String status = task.isCompleted ? "[✓]" : "[ ]";
      print("$status ${i + 1}. ${task.title}\n    Subject: ${task.subject}\n    Task Priority: ${task.priority.stringValue}${task.description != null ? "\n    Description: ${task.description}" : ""}\n");
    }
    return true;
  }

  Set<String> getUniqueSubjects() {
    Set<String> uniqueSubjects = tasks.map((task) => task.subject).toSet();
    return uniqueSubjects;
  }

  Map<String, int> getSubjectTaskCount() {
    Map<String, int> subjectTaskCount = {};
    for (Task task in tasks) {
      subjectTaskCount[task.subject] = (subjectTaskCount[task.subject] ?? 0) + 1;
    }
    return subjectTaskCount;
  }

  displayStatistics() {
    int totalTasks = tasks.length;
    int completedTasks = tasks.where((task) => task.isCompleted).length;
    int incompleteTasks = totalTasks - completedTasks;

    print("Total Tasks: $totalTasks");
    print("Completed Tasks: $completedTasks");
    print("Incomplete Tasks: $incompleteTasks");

    print("\nSubjects:");
    for (String subject in getUniqueSubjects()) {
      print("$subject - ${getSubjectTaskCount()[subject]} task${getSubjectTaskCount()[subject] == 1 ? '' : 's'}");
    }

    print("\nHigh Priority Tasks:");
    List<Task> highPriorityTasks = tasks.where((task) => !task.isCompleted && task.priority == TaskPriority.high).toList();
    if (highPriorityTasks.isEmpty) {
      print("\nNo high priority task to complete.");
    } else {
      for (Task task in highPriorityTasks) {
        print("- ${task.title}");
      }
    }
  }

  Stream<String> displayTaskUpdates() async* {
    if (log.isEmpty) yield "No task updates available.";

    for (String entry in log) {
      yield entry+"\n";
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
