import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObsecureText = true;

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
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Minimum length password 8 character with Letter and Number combination',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: _isObsecureText,
                      decoration:  InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        suffixIcon: toggleButton(),
                    ),
                  ),
                  const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      obscureText: _isObsecureText,
                      decoration:  InputDecoration(
                        hintText: 'Confirm Password',
                        labelText: 'Confirm Password',
                        suffixIcon: toggleButton(),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
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
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                                (route) => false);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColor.themeColor,
                          ),
                          child: const Text('Sign in'),
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

  IconButton toggleButton() {
    return IconButton(
      onPressed: () {
        _isObsecureText = !_isObsecureText;
        setState(() {});
      },
      icon: Icon(
        _isObsecureText ? Icons.visibility_off : Icons.visibility,
      ),
      color: Colors.grey,
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
