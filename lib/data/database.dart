import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  // Typed list to store to-do items. Each item contains a task (String) and its completion status (bool).
  List<List<dynamic>> toDoList = [];

  // Reference to the Hive box
  final _myBox = Hive.box('mybox');

  // Key for the to-do list in the Hive database
  static const String toDoListKey = "TODOLIST";

  /// Creates initial data when the app is opened for the first time
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
    updateDataBase(); // Update the database immediately with the initial data
  }

  /// Loads the data from the Hive database, ensuring null safety
  void loadData() {
    toDoList = List<List<dynamic>>.from(
        _myBox.get(toDoListKey, defaultValue: toDoList) ?? []);
  }

  /// Updates the database with the current state of the to-do list
  void updateDataBase() {
    _myBox.put(toDoListKey, toDoList);
  }
}
