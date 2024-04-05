import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/screens/auth/email_verification_screen.dart';
import 'package:task_manager_project/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_project/presentation/screens/auth/sign_up_screen.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';
import 'package:task_manager_project/presentation/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordObsecured = true;
  final SignInController _signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgImageScreen(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'example@gmail.com',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey,)
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your email address';
                      }
                      return null;
                    }
                    ,
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
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<SignInController>(
                      builder: (signInController) {
                        return Visibility(
                          visible: signInController.inProgress == false,
                          replacement: const Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                _login();
                              }

                            },
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColor.secondaryTextColor,
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmailVerifyScreen(),
                          ),
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: AppColor.primaryTextColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );*/
                          Get.to(()=> const SignUpScreen());
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColor.themeColor,
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final result = await _signInController.signIn(
        _emailTEController.text.trim(), _passwordTEController.text);

    if(result){
      if(!mounted){
        return;
      }


      if(mounted) {
        /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ),
                (route) => false);*/
        Get.offAll(()=> const MainBottomNavScreen());
      }
    }else{
      if(mounted){
        return showSnackBarMessage(
            context, _signInController.errorMessage);
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
      hoverColor: Colors.transparent,
    );
  }



  @override
  void dispose() {
    _passwordTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}
