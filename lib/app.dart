import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/spalsh_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager Project',
      home: SplashScreen(),
    );
  }
}
