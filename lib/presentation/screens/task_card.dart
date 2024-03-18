import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task_item.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utility/url.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';
import 'package:task_manager_project/presentation/widgets/snackbar_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
      {
        super.key,
        required this.taskItem,
        required this.onDelete,
      }
      );

  final TaskItem taskItem;
  final VoidCallback onDelete;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
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
              widget.taskItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.taskItem.description ?? ''),
            Text('Date: ${widget.taskItem.createdDate}'),
            Row(
              children: [
                 Chip(
                  label: Text(widget.taskItem.status ?? ''),
                ),
                const Spacer(),
                Visibility(
                  visible: _updateTaskStatusInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                    onPressed: (){
                      _showUpdateStatusDialog(widget.taskItem.sId!);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: AppColor.themeColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: widget.onDelete,
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

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskStatusInProgress = true;
    setState(() {});
    final response =
    await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskStatusInProgress = false;
    if (response.isSuccess) {
      _updateTaskStatusInProgress = false;
      // _getDataFromApi();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Update task status has been failed');
      }
    }
  }

}
