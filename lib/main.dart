import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login/login.dart';
import 'package:todo/auth/register/register.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/providers/app_config.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/home/tabs/tasks/edit_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyD2Ykf0-pu8H1Tu4aus9YmSzRU-iwSQLAk',
          appId: 'com.example.todo_app',
          messagingSenderId: '871362468048', // project_number
          projectId: 'todo-app-ad4f6',
        ))
      : await Firebase.initializeApp();

  await FirebaseFirestore.instance.disableNetwork();

  // Cash Doc Size
  FirebaseFirestore.instance.settings = const Settings(
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppConfig()),
          ChangeNotifierProvider(create: (context) => TaskProvider()..getAllTasks()),
        ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Login.routeName,
      routes: {
        Login.routeName: (_) => Login(),
        Register.routeName: (_) => Register(),
        HomeScreen.routeName: (_) => HomeScreen(),
        EditTask.routeName: (_) => EditTask(),
      },
      theme: AppTheme.lightTheme,
      themeMode: provider.appTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.language),
    );
  }
}
