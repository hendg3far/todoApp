import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/firebase_utils.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectDate = DateTime.now();

  Future<void> getAllTasks() async {
    List<Task> allTasks = await FirebaseUtils.getAllTasks();
    var tasks = allTasks
        .where((task) =>
            task.date.day == selectDate.day &&
            task.date.month == selectDate.month &&
            task.date.year == selectDate.year)
        .toList();

    taskList = tasks;
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectDate = date;
    notifyListeners();
  }

  Future<void> updateTaskStatus(Task task) async {
    await FirebaseUtils.updateTaskInFireStore(task.id, {
      'title': task.title,
      'description': task.description,
      'date': task.date.millisecondsSinceEpoch,
      'isDone': task.isDone
    });
    notifyListeners();
  }

   Future<void> editTask(Task task) async {
    await FirebaseUtils.updateTaskInFireStore(task.id, {
      'title': task.title,
      'description': task.description,
      'date': task.date.millisecondsSinceEpoch,
    });
   notifyListeners();
  }
}
