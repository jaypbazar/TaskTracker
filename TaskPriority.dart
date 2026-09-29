enum TaskPriority { 
  low('low'), 
  medium('medium'), 
  high('high');

  final String stringValue;

  const TaskPriority(this.stringValue);
}