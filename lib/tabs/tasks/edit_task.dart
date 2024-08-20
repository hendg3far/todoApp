import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/providers/app_config.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit_task';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Task;
    selectedDate = args.date;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppTheme.primaryColor,
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: provider.appTheme == ThemeMode.light
                  ? AppTheme.whiteColor
                  : AppTheme.darkColor,
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.04
            ),
            child: Form(
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
                      args.title = value;
                    },
                    initialValue: args.title,
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
                      args.description = value;
                    },
                    initialValue: args.description,
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
                      showCalendar(args);
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
                      taskProvider.editTask(args);
                      Navigator.pop(context);
                      taskProvider.getAllTasks();
                    },
                    child: Text(
                      'Edit Task',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppTheme.whiteColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCalendar(Task args) async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    selectedDate = chosenDate ?? selectedDate;
    if (chosenDate != null) {
      args.date = selectedDate;
    }
    setState(() {});
  }
}
