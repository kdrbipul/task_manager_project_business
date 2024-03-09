import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/count_by_status_wrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utility/url.dart';
import 'package:task_manager_project/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager_project/presentation/screens/task_card.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';
import 'package:task_manager_project/presentation/widgets/profile_bar.dart';
import 'package:task_manager_project/presentation/widgets/snackbar_message.dart';
import 'package:task_manager_project/presentation/widgets/task_counter_section.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllNewTaskStatusInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();

  @override
  void initState() {
    super.initState();
    _getNewTaskStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BgImageScreen(
        child: Column(
          children: [
            Visibility(
              visible: _getAllNewTaskStatusInProgress == false,
                replacement: const Padding(
                  padding: EdgeInsets.all(16),
                    child: LinearProgressIndicator()),
                child: taskCounterSection),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskCard();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<void> _getNewTaskStatus() async {
    _getAllNewTaskStatusInProgress = false;
    setState(() {});

    final response = await NetworkCaller.getRequest(
      Urls.taskStatusCount,
    );

    if (response.isSuccess) {
      _countByStatusWrapper = CountByStatusWrapper.fromJson(response.responseBody);
      _getAllNewTaskStatusInProgress = false;
      setState(() {});
    } else {
      _getAllNewTaskStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get task count by status has been failed');
      }
    }
  }
}
