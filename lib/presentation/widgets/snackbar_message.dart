import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';

void showSnackBarMessage(BuildContext context, String message,
    [bool isErrorMessage = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isErrorMessage ? Colors.red : AppColor.themeColor,
    ),
  );
}
