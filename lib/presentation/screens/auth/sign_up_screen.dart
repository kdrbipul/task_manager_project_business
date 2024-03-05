import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utility/url.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';
import 'package:task_manager_project/presentation/widgets/snackbar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordObsecured = true;
  bool _isRegistrationInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgImageScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey,),
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty ?? true){
                        return 'Enter your valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _firstNameTEController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                      labelText: 'First Name',
                      prefixIcon: Icon(Icons.person, color: Colors.grey,)
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty ?? true){
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                        prefixIcon: Icon(Icons.person, color: Colors.grey,),
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty ?? true){
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _phoneTEController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                      labelText: 'Mobile',
                      prefixIcon: Icon(Icons.mobile_friendly_outlined, color: Colors.grey,)
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty ?? true){
                        return 'Enter your valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: _passwordObsecured,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey,),
                      suffixIcon: togglePassword(),
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty ?? true){
                        return 'Enter your password';
                      }
                      if(value!.length <= 6){
                        return 'Password should more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isRegistrationInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUp();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: AppColor.primaryTextColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColor.themeColor,
                        ),
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _signUp() async {
    _isRegistrationInProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.registration, inputParams);

    _isRegistrationInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Registration success! Please login.');
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Registration failed! Try again.', true);
      }
    }
  }



  IconButton togglePassword() {
    return IconButton(
      onPressed: () {
        _passwordObsecured = !_passwordObsecured;
        setState(() {});
      },
      icon: Icon(_passwordObsecured ? Icons.visibility_off : Icons.visibility),
      color: Colors.grey,
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
