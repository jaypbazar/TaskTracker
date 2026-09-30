import 'dart:io';

import 'TaskTracker.dart';

main() {
  Tasktracker tasktracker = Tasktracker();
  tasktracker.populateSampleTasks();

  while (true) {
    stdout.write("\x1B[2J\x1B[0;0H"); // Clear the console
    print("=======================================================");
    print("\t\tWelcome to Task Tracker");
    print("=======================================================");
    print("0. Exit");
    print("1. Add Task");
    print("2. View Tasks");
    print("3. Complete Task");
    print("4. Search Tasks");
    print("5. Statistics");
    print("6. Watch Task Updates");

    stdout.write("\nEnter your choice: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "0":
        print("\nThank you for using Task Tracker. Goodbye!");
        exit(0);
      case "1":
        // Add Task
        print("\n==================== Add New Task ====================\n");
        stdout.write("Enter task title: ");
        String title = stdin.readLineSync() ?? '';
        stdout.write("Enter task subject: ");
        String subject = stdin.readLineSync() ?? '';
        stdout.write("Enter task description(optional): ");
        String? description = stdin.readLineSync();

        if (tasktracker.addTask(
          title: title,
          subject: subject,
          description: description,
        )) {
          print("\nTask added successfully!");
        } else {
          print("\nFailed to add task.");
        }
        break;
      case "2":
        // View Tasks
        print("\n==================== List of Tasks ====================\n");
        tasktracker.viewTasks();
        break;
      case "3":
        // Complete Task
        break;
      case "4":
        // Search Tasks
        break;
      case "5":
        // Statistics
        break;
      case "6":
        // Watch Task Updates
        break;
      default:
        print("\nInvalid choice. Please try again.");
    }

    stdout.write("\nPress Enter to continue...");
    stdin.readLineSync();
  }
}
