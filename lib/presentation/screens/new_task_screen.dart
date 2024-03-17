import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/count_by_status_wrapper.dart';
import 'package:task_manager_project/data/models/task_list_wrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utility/url.dart';
import 'package:task_manager_project/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager_project/presentation/screens/task_card.dart';
import 'package:task_manager_project/presentation/screens/task_counter_card.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';
import 'package:task_manager_project/presentation/widgets/profile_bar.dart';
import 'package:task_manager_project/presentation/widgets/snackbar_message.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllNewTaskStatusInProgress = false;
  bool _getNewTaskListInProgress = false;
  bool _deleteTaskInProgress = false;
  bool _updateTaskStatusInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getDataFromApi();
  }

  void _getDataFromApi() {
    _getNewTaskStatus();
    _getAllNewTaskList();
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
              child: Visibility(
                visible: _getNewTaskListInProgress == false &&
                    _deleteTaskInProgress == false &&
                    _updateTaskStatusInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async => _getDataFromApi(),
                  child: ListView.builder(
                    itemCount: _newTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskItem: _newTaskListWrapper.taskList![index],
                        onDelete: () {
                          _deleteTaskById(
                              _newTaskListWrapper.taskList![index].sId!);
                        },
                        onEdit: () {
                          _showUpdateStatusDialog(
                              _newTaskListWrapper.taskList![index].sId!);
                        },
                      );
                    },
                  ),
                ),
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

  Widget get taskCounterSection {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskScreenCounterCard(
              title: _countByStatusWrapper.listOfTaskByStatusData![index].sId ??
                  '',
              amount:
                  _countByStatusWrapper.listOfTaskByStatusData![index].sum ?? 0,
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select Status'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Text('New'),
                  trailing: Icon(Icons.check),
                ),
                ListTile(
                  title: const Text('Complete'),
                  onTap: () {
                    _updateTaskById(id, 'Complete');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Progress'),
                  onTap: () {
                    _updateTaskById(id, 'Progress');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Cancelled'),
                  onTap: () {
                    _updateTaskById(id, 'Cancelled');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _getNewTaskStatus() async {
    _getAllNewTaskStatusInProgress = false;
    setState(() {});

    final response = await NetworkCaller.getRequest(
      Urls.taskStatusCount,
    );

    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
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

  Future<void> _getAllNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getNewTaskListInProgress = false;
      setState(() {});
    } else {
      _getNewTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get new task list has been failed');
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskInProgress = false;
    if (response.isSuccess) {
      _getDataFromApi();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Delete task has been failed');
      }
    }
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskStatusInProgress = false;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskStatusInProgress = true;
    if (response.isSuccess) {
      _getDataFromApi();
    } else {
      _updateTaskStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Update task status has been failed');
      }
    }
  }
}
