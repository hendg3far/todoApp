import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';
  var selectedDate = DateTime.now();

  late TaskProvider taskProvider;

  @override
  Widget build(BuildContext context) {
    taskProvider = Provider.of<TaskProvider>(context);
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add new Task',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your task',
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter task title';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    title = value;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter your description',
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter task description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    description = value;
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  'Select Date',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    showCalendar();
                  },
                  child: Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  child: Text(
                    'Add Task',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppTheme.whiteColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void addTask() {
    if (_formKey.currentState!.validate() == true) {
      Task task =
          Task(title: title, description: description, date: selectedDate);
      FirebaseUtils.addTaskToFirestore(task).timeout(const Duration(seconds: 2),
          onTimeout: () {
        print('Task Added Successfully');
        Navigator.pop(context);
        taskProvider.getAllTasks();
      }).catchError((_) {
        print('Error');
      });
    }
  }

  void showCalendar() async {
    var choosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    selectedDate = choosenDate ?? selectedDate;
    setState(() {});
  }
}
