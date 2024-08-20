import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/providers/app_config.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/tabs/tasks/task_item.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: AppTheme.primaryColor,
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
            ),
            PositionedDirectional(
              top: MediaQuery.of(context).size.height * 0.06,
              start: MediaQuery.of(context).size.width * 0.05,
              child: Text(
                'To Do List',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14,),
              child: CustomDateTimeLine(),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, index) => TaskItem(
              task: taskProvider.taskList[index],
            ),
            itemCount: taskProvider.taskList.length,
          ),
        ),
      ],
    );
  }
}

class CustomDateTimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    var taskProvider = Provider.of<TaskProvider>(context);

    return EasyInfiniteDateTimeLine(
      showTimelineHeader: false,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      focusDate: taskProvider.selectDate,
      onDateChange: (selectedDate) {
        taskProvider.changeSelectedDate(selectedDate);
        taskProvider.getAllTasks();
      },
      dayProps: EasyDayProps(
        dayStructure: DayStructure.monthDayNumDayStr,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff3b5998),
                AppTheme.primaryColor,
              ],
            ),
          ),
        ),
        inactiveDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            fontSize: 18,
            color: provider.appTheme == ThemeMode.light
                ? AppTheme.darkColor
                : AppTheme.whiteColor,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: provider.appTheme == ThemeMode.light
                ? AppTheme.whiteColor
                : AppTheme.darkColor,
          ),
        ),
        todayStyle: DayStyle(
          dayNumStyle: TextStyle(
            fontSize: 18,
            color: provider.appTheme == ThemeMode.light
                ? AppTheme.darkColor
                : AppTheme.whiteColor,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: provider.appTheme == ThemeMode.light
                ? AppTheme.whiteColor
                : AppTheme.darkColor,
          ),
        ),
      ),
    );
  }
}
