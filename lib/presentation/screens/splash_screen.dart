import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/controllers/auth_contorller.dart';
import 'package:task_manager_project/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_project/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_project/presentation/widgets/app_logo.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToSignIn();
  }

  Future<void> _moveToSignIn() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    bool loginState = await AuthController.isUserLoggedIn();

    if (mounted) {
      if(loginState){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavScreen(),
          ),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BgImageScreen(
        child: Center(
          child: AppLogo(),
        ),
      )
    );
  }
}





