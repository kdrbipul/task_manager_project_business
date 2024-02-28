import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';

PreferredSizeWidget get profileAppBar{
  return AppBar(
    backgroundColor: AppColor.themeColor,
    title: Row(
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
          onPressed: () {},
          icon: const Icon(Icons.logout_outlined,),
        ),
      ],
    ),
  );
}