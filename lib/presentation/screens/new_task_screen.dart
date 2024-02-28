import 'package:flutter/material.dart';
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
                itemBuilder: (
                    context, index) {
                  return  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Title will be here'),
                        const Text('Description will be here'),
                        const Text('Date: 28-02-2024'),

                        Row(
                          children: [
                            const Chip(label: Text('new'),),
                            const Spacer(),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.edit),),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outline, color: Colors.red,),),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget get taskCounterSection{
    return  SizedBox(
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


