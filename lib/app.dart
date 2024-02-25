import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/screens/spalsh_screen.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager Project',
      home: const SplashScreen(),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.themeColor,
            foregroundColor: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
          ),
        ),
        textTheme: const TextTheme(
          titleLarge:TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColor.primaryTextColor,
          ),
        )
      ),
    );
  }
}
