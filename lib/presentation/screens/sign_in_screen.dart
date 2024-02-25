import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_project/presentation/utils/assets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                'Get Started With',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // TextFormField()
            ],
          ),
        )
      ],
    ));
  }
}
