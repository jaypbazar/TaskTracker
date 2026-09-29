import 'dart:io';

import 'TaskTracker.dart';

main(){
  Tasktracker tasktracker = Tasktracker();

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

  stdout.write("Enter your choice: ");
  String? choice = stdin.readLineSync();

  switch(choice){
    case "0":
      print("Exiting...");
      break;
    case "1":
      // Add Task
      stdout.write("Enter task title: ");
      String title = stdin.readLineSync() ?? '';
      stdout.write("Enter task subject: ");
      String subject = stdin.readLineSync() ?? '';
      stdout.write("Enter task description(optional): ");
      String? description = stdin.readLineSync();
      
      if (tasktracker.addTask(title: title, subject: subject, description: description)) {
        print("Task added successfully!");
      } else {
        print("Failed to add task.");
      }
      break;
    case "2":
      // View Tasks
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
      print("Invalid choice. Please try again.");
  }
}