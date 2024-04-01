import 'package:get/get.dart';
import 'package:task_manager_project/presentation/controllers/sign_in_controller.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SingInController());
  }

}
