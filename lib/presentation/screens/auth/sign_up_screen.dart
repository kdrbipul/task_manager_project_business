import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';

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
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.arrow_circle_right_outlined),
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
