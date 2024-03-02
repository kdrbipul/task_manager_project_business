import 'package:flutter/material.dart';
import 'package:task_manager_project/app.dart';
import 'package:task_manager_project/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_project/presentation/screens/update_profile_screen.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColor.themeColor,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
          TaskManager.navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 10.0),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abdul Kader',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'example@gmail.com',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  TaskManager.navigatorKey.currentState!.context,
                  MaterialPageRoute(
                    builder: (contex) => const SignInScreen(),
                  ),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
    ),
  );
}
