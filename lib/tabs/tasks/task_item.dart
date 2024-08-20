import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/tabs/tasks/edit_task.dart';

class TaskItem extends StatelessWidget {
  Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EditTask.routeName, arguments: task);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            extentRatio: 0.30,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  FirebaseUtils.deleteTaskFromFirestore(task.id).timeout(
                    const Duration(seconds: 1),
                    onTimeout: () {
                      print('Task deleted');
                      taskProvider.getAllTasks();
                    },
                  );
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ],
          ),
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                      height: 62,
                      width: 4,
                      color: AppTheme.primaryColor,
                      margin: const EdgeInsetsDirectional.only(end: 15)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: task.isDone ? Colors.green : null
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          task.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      task.isDone = !task.isDone;
                      taskProvider.updateTaskStatus(task);
                      taskProvider.getAllTasks();
                    },
                    icon: Icon(
                      Icons.check,
                      color: AppTheme.whiteColor,
                      size: 35,
                    ),
                    style: IconButton.styleFrom(
                        backgroundColor: task.isDone ? Colors.green : AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
