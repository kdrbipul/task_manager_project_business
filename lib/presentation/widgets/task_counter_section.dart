import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/screens/task_counter_card.dart';

Widget get taskCounterSection {
  return SizedBox(
    height: 100,
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