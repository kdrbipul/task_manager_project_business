import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/screens/task_card.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';
import 'package:task_manager_project/presentation/widgets/profile_bar.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BgImageScreen(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  // return const TaskCard();
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}


