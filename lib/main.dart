import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/app.dart';

void main() {
  runApp(DevicePreview(
    enabled: false,
    builder: (context) {
      return  TaskManager();
    }
  ));
}

