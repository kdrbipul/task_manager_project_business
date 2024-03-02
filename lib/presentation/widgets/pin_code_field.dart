import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/presentation/utils/app_color.dart';



class PinCodeField extends StatelessWidget {
  const PinCodeField({
    super.key,
    required TextEditingController pinTEController,
  }) : _pinTEController = pinTEController;

  final TextEditingController _pinTEController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: _pinTEController,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: AppColor.themeColor,
        inactiveFillColor: Colors.white,
        inactiveColor: AppColor.themeColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      appContext: context,
    );
  }
}