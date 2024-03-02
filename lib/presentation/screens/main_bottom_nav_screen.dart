import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/screens/cancled_task_screen.dart';
import 'package:task_manager_project/presentation/screens/complete_task_screen.dart';
import 'package:task_manager_project/presentation/screens/new_task_screen.dart';
import 'package:task_manager_project/presentation/screens/progress_task_screen.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  int _currentSelectedIndex = 0;

  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompleteTaskScreen(),
    const ProgressTaskScreen(),
    const CancledTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _screens[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        selectedItemColor: AppColor.themeColor,
        unselectedItemColor: AppColor.secondaryTextColor,
        backgroundColor: AppColor.themeColor,
        showUnselectedLabels: true,
        onTap: (index){
          _currentSelectedIndex = index;
          if (mounted){
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_outlined),
            label: 'New Task'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Complete'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc_rounded),
            label: 'Progress'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close_rounded),
            label: 'Cancelled'
          ),
        ],
      ),

    );
  }
}
