import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgImageScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    // controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    // controller: _emailTEController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                      labelText: 'First Name',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    // controller: _emailTEController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    // controller: _emailTEController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                      labelText: 'Mobile',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    // controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
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
}
