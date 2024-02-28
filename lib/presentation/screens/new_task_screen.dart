import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/screens/task_card.dart';
import 'package:task_manager_project/presentation/screens/task_counter_card.dart';
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
    return Scaffold(
      appBar: profileAppBar,
      body: BgImageScreen(
        child: Column(
          children: [
            taskCounterSection,
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const TaskCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return const TaskScreenCounterCard(
            amount: 12,
            title: 'New',
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}


