import 'package:task_manager_project/data/models/user_data.dart';

class LoginResponse {
  String? status;
  String? token;
  UserData? userDate;

  LoginResponse({this.status, this.token, this.userDate});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userDate = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

