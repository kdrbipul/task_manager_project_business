import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/app.dart';
import 'package:task_manager_project/presentation/controllers/auth_controller.dart';
import 'package:task_manager_project/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_project/presentation/screens/update_profile_screen.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColor.themeColor,
    title: GestureDetector(
      onTap: () {
        /*Navigator.push(
          TaskManager.navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );*/
        Get.to(()=> const UpdateProfileScreen());
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: MemoryImage(base64Decode(AuthController.userData!.photo!)),
          ),
          const SizedBox(width: 10.0),
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName ?? '',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                 Text(
                  AuthController.userData?.email ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            color: Colors.white,
            onPressed: ()  async{
              await AuthController.clearUserData();

              Navigator.pushAndRemoveUntil(
                  TaskManager.navigatorKey.currentState!.context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
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
