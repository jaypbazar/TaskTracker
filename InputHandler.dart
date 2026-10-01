import 'dart:io';

String? getUserInput({required String prompt, required bool Function(String?) isValid, String errorMessage = "Invalid input. Please try again."}) {
  stdout.write(prompt);
  String? rawInput = stdin.readLineSync();
  String? cleanedInput = (rawInput == null || rawInput.trim().isEmpty) ? null : rawInput.trim();

  if (isValid(cleanedInput)) {
    return cleanedInput;
  }
  
  print('\n$errorMessage');
  return getUserInput(prompt: prompt, isValid: isValid, errorMessage: errorMessage);
}
