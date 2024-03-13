import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task_item.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskItem});

  final TaskItem taskItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(taskItem.description ?? ''),
            Text('Date: ${taskItem.createdDate}'),
            Row(
              children: [
                 Chip(
                  label: Text(taskItem.status ?? ''),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: AppColor.themeColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
