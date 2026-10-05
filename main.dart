import 'dart:io';

import 'InputHandler.dart';
import 'TaskTracker.dart';

main() async {
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
    print("3. Modify a Task");
    print("4. Search Tasks");
    print("5. Statistics");
    print("6. Watch Task Updates");

    String? choice = getUserInput(
      prompt: "\nEnter your choice: ",
      isValid: (input) =>
          input != null && ['0', '1', '2', '3', '4', '5', '6'].contains(input),
      errorMessage: "Invalid choice. Please try again.",
    );

    switch (choice) {
      case "0":
        print("\nThank you for using Task Tracker. Goodbye!");
        exit(0);
      case "1":
        // Add Task
        print("\n==================== Add New Task ====================\n");

        String title =
            getUserInput(
              prompt: "Enter task title: ",
              isValid: (input) => input != null,
              errorMessage: "Task title cannot be empty. Please try again.",
            ) ??
            '';

        String subject =
            getUserInput(
              prompt: "Enter task subject: ",
              isValid: (input) => input != null,
              errorMessage: "Task subject cannot be empty. Please try again.",
            ) ??
            '';

        String? description = getUserInput(
          prompt: "Enter task description (optional): ",
          isValid: (input) => input == null || input.isNotEmpty,
        );

        if (tasktracker.addTask(
          title: title,
          subject: subject,
          description: description,
        )) {
          print("\nTask added successfully!");
          tasktracker.log.add("(${DateTime.now().toString()}) Added a new task: '$title' with subject '$subject'.");
        } else {
          print("\nFailed to add task.");
        }
        break;
      case "2":
        // View Tasks
        print("\n==================== List of Tasks ====================\n");
        tasktracker.viewSortedTasks();
        tasktracker.log.add("(${DateTime.now().toString()}) Viewed all tasks.");
        break;
      case "3":
        // Modify a Task
        print("\n=================== Modify a Task ===================\n");
        tasktracker.viewTasks();

        String? selectedTask = getUserInput(
          prompt: "\nSelect a task to modify (0 to go back): ",
          isValid: (input) {
            if (input == '' || input == null) return false;
            int? taskNumber = int.tryParse(input);
            return taskNumber != null &&
                taskNumber >= 0 &&
                taskNumber <= tasktracker.tasks.length;
          },
          errorMessage: "Invalid input. Please try again.",
        );
        if (selectedTask == '0') {
          print("\nGoing back to the main menu.");
          break;
        }
        int taskNumber = int.parse(selectedTask!);
        tasktracker.displayTask(taskNumber-1); 

        print("\nHow would you like to modify this task?");
        print("1. Edit task");
        print("2. Delete task");
        print("3. Change priority");
        print("4. Mark task as complete");

        String? modChoice = getUserInput(
          prompt: "\nEnter your choice (0 to go back): ",
          isValid: (input) => input != null && ['0', '1', '2', '3', '4'].contains(input),
          errorMessage: "Invalid choice. Please try again."
        );

        switch (modChoice) {
          case '0':
            print("\nGoing back to the main menu.");
            break;
          case '1':
            String newTitle = getUserInput(
              prompt: "\nEnter new title (leave blank to keep current): ",
              isValid: (input) => input != null,
            ) ?? tasktracker.tasks[taskNumber-1].title;

            String newSubject = getUserInput(
              prompt: "Enter new subject (leave blank to keep current): ",
              isValid: (input) => input != null,
            ) ?? tasktracker.tasks[taskNumber-1].subject;

            String? newDescription = getUserInput(
              prompt: "Enter new description (leave blank to keep current): ",
              isValid: (input) => input == null || input.isNotEmpty,
            ) ?? tasktracker.tasks[taskNumber-1].description;

            if (tasktracker.editTask(
              index: taskNumber-1,
              title: newTitle,
              subject: newSubject,
              description: newDescription,
            )) { 
              print("\nTask updated successfully.");
              tasktracker.log.add("(${DateTime.now().toString()}) Edited task ${tasktracker.getTaskTitleAtIndex(taskNumber-1)}: New title '$newTitle', New subject '$newSubject'.");
            } else {
              print("\nFailed to update task.");
            }
            break;
          case '2':
            String? confirm = getUserInput(
              prompt: "\nAre you sure you want to delete this task? (y/n): ", 
              isValid: (input) => input != null && ['y', 'n'].contains(input),
              errorMessage: "\nInvalid choice. Please try again."
            );
            if(confirm == 'y') {
              if (tasktracker.deleteTask(taskNumber-1)) { 
                print("\nTask deleted successfully.");
                tasktracker.log.add("(${DateTime.now().toString()}) Deleted task ${tasktracker.getTaskTitleAtIndex(taskNumber-1)}.");
              } 
              else {
                print("\nTask was not deleted.");
              }
            }
            else {
              print("\nDeletion cancelled.");
            }
            break;
          case '3':
            print("\nAdjusting priority...");
            print("1. Increase priority");
            print("2. Decrease priority");

            String? priorityChoice = getUserInput(
              prompt: "\nEnter your choice (0 to go back): ",
              isValid: (input) =>
                  input != null && ['0', '1', '2'].contains(input),
              errorMessage: "Invalid choice. Please try again.",
            );

            switch (priorityChoice) {
              case '0':
                print("\nGoing back to the main menu.");
                break;
              case '1':
                if (tasktracker.increaseTaskPriority(taskNumber - 1)) { 
                  print("\nTask priority increased.");
                  tasktracker.log.add("(${DateTime.now().toString()}) Increased priority of task ${tasktracker.getTaskTitleAtIndex(taskNumber-1)}.");
                } else {
                  print("\nTask is already at the highest priority.");
                }
                break;
              case '2':
                if (tasktracker.decreaseTaskPriority(taskNumber - 1)) {
                  print("\nTask priority decreased.");
                  tasktracker.log.add("(${DateTime.now().toString()}) Decreased priority of task ${tasktracker.getTaskTitleAtIndex(taskNumber-1)}.");
                } else {
                  print("\nTask is already at the lowest priority.");
                }
                break;
            }
            break;
          case '4':
            if (tasktracker.markTaskAsCompleted(taskNumber-1)) {
              print("\nTask successfully marked complete.");
              tasktracker.log.add("(${DateTime.now().toString()}) Marked task ${tasktracker.getTaskTitleAtIndex(taskNumber-1)} as complete.");
            } else {
              print("\nTask is already completed.");
            }
            break;
        }
        break;
      case "4":
        // Search Tasks
        String searchTerm = getUserInput(
          prompt: "\nEnter a search term (title or subject): ",
          isValid: (input) => input != null && input.isNotEmpty,
          errorMessage: "Search term cannot be empty. Please try again.",
        ) ?? '';

        print("\n=================== Search Results ====================\n");
        if (!tasktracker.searchTasks(searchTerm)) {
          print("No tasks found matching the search term '$searchTerm'.");
        }
        tasktracker.log.add("(${DateTime.now().toString()}) Searched for tasks with term '$searchTerm'.");
        break;
      case "5":
        // Statistics
        print("\n=================== Task Statistics ===================\n");
        tasktracker.displayStatistics();
        tasktracker.log.add("(${DateTime.now().toString()}) Viewed task statistics.");
        break;
      case "6":
        // Simulate Task Updates
        print("\nConecting to task updates...\n");
        await for (String update in tasktracker.displayTaskUpdates()) {
          print(update);
        }
        break;
      default:
        print("\nInvalid choice. Please try again.");
    }

    stdout.write("\nPress Enter to continue...");
    stdin.readLineSync();
  }
}
