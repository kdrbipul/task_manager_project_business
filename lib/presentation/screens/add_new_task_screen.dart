import 'package:flutter/material.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utility/url.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';
import 'package:task_manager_project/presentation/widgets/profile_bar.dart';
import 'package:task_manager_project/presentation/widgets/snackbar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isAddNewTaskInProgress = false;
  bool _shouldRefreshNewTaskList = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        if(didPop){
          return;
        }
        Navigator.pop(context, _shouldRefreshNewTaskList);
      },
      child: Scaffold(
        appBar: profileAppBar,
        body: BgImageScreen(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      labelText: 'Title',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your title';
                      }
                      return null;
                  },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLength: 250,
                    // maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      labelText: 'Description',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isAddNewTaskInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _addNewTask();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async{
    _isAddNewTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams ={
      "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
      "status":"New"
    };

    final response = await NetworkCaller.postRequest(Urls.createTask, inputParams);

    _isAddNewTaskInProgress = false;
    setState(() {});

    if(response.isSuccess){
      _shouldRefreshNewTaskList = true;
      _titleTEController.clear();
      _descriptionTEController.clear();
      if(mounted){
        showSnackBarMessage(context, 'New task has been added');
      }
      // Navigator.pop(context);
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Add new task failed', true);
      }
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
