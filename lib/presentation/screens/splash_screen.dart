import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/controllers/auth_controller.dart';
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
    _moveToNextPage();
  }

  Future<void> _moveToNextPage() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    bool isLoggedIn = await AuthController.isUserLoggedIn();

    if (mounted) {
      if(isLoggedIn){
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavScreen(),
          ),
        );*/
        Get.off(()=> const MainBottomNavScreen());
      }else{
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );*/
        Get.off(()=> const SignInScreen());
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





