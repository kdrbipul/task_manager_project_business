import 'package:get/get.dart';
import 'package:task_manager_project/data/models/login_response.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utility/url.dart';
import 'package:task_manager_project/presentation/controllers/auth_controller.dart';

class SingInController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Login Failed! Try again';

  Future<bool> signIn(String email, String password) async{
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "password": password,
    };
    final ResponseObject response =
    await NetworkCaller.postRequest(Urls.login, inputParams, fromSignIn: true);
    _inProgress = false;


    if(response.isSuccess){


      LoginResponse loginResponse = LoginResponse.fromJson(response.responseBody);
      // Save the data local cache
      await AuthController.saveUserDate(loginResponse.userDate!);
      await AuthController.saveUserToken(loginResponse.token!);

      update();
      return true;

    }else{
      _errorMessage = response.errorMessage;
      update();
      return false;
    }

  }
}