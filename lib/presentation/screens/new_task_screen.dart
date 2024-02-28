import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';
import 'package:task_manager_project/presentation/widgets/profile_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: profileAppBar,
      body: const BgImageScreen(
        child: Column(
          children: [],
        ),
      ),
    );
  }

}


