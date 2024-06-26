import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/controller_binder.dart';
import 'package:task_manager_project/presentation/screens/splash_screen.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';

class TaskManager extends StatelessWidget {

   TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager Project',
      home: const SplashScreen(),
      theme: _themeData,
      initialBinding: ControllerBinding(),
    );
  }



  final ThemeData _themeData = ThemeData(
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
          foregroundColor: AppColor.buttonTExtColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    ),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColor.primaryTextColor,
        ),
        bodySmall:
        TextStyle(color: AppColor.secondaryTextColor, fontSize: 16)),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.themeColor,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )
    ),
  );
}

