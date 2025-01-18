import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/intro_screen.dart';
import 'screens/tasks_page.dart';

void main() async {
  await Hive.initFlutter("hive_box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App', // Updated title
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: 'intro',
      routes: {
        'intro': (context) => const IntroPage(),
        'tasks': (context) => const TasksPage(),
      },
    );
  }
}
