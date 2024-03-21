import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project/data/models/user_data.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/utility/url.dart';
import 'package:task_manager_project/presentation/controllers/auth_contorller.dart';
import 'package:task_manager_project/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_project/presentation/widgets/bg_image_screen.dart';
import 'package:task_manager_project/presentation/widgets/profile_bar.dart';
import 'package:task_manager_project/presentation/widgets/snac_kbar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});


  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}


class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObsecureText = true;
  bool _updateProfileInProgress = false;
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _phoneTEController.text = AuthController.userData?.mobile ?? '';
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
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
                    height: 48,
                  ),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  imagePickerButton(),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _firstNameTEController,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                      labelText: 'First Name',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _lastNameTEController,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneTEController,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                      labelText: 'Mobile',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your valid phone number';
                      }
                      return null;
                    },
                    maxLength: 11,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: _isObsecureText,
                    decoration: InputDecoration(
                      hintText: 'Password(Optional)',
                      labelText: 'Password(Optional)',
                      suffixIcon: togglePassword(),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _updateProfileInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: () {
                          _updteProfile();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePickerButton() {
    return GestureDetector(
      onTap: (){
        pickImageFromGallery();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  )),
              child: const Text(
                'Photo',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
                child: Text(
                  maxLines: 1,
              _pickedImage?.name ?? '',
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async{
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
}

Future<void> _updteProfile()  async {
    String? photo;
    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams = {
      "email":_emailTEController.text,
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_phoneTEController.text.trim(),
    };

    if(_passwordTEController.text.isNotEmpty){
      inputParams['password'] = _passwordTEController.text;
    }

    if(_pickedImage != null){
      List<int> bytes = File(_pickedImage!.path).readAsBytesSync();
      photo = base64UrlEncode(bytes);
      inputParams['photo'] = photo;

      final response = await NetworkCaller.postRequest(Urls.updateProfile, inputParams);
      _updateProfileInProgress = false;
      if(response.isSuccess){
        if(response.responseBody['status'] == 'success'){
          UserData userData = UserData(
            email: _emailTEController.text,
            firstName: _firstNameTEController.text.trim(),
            lastName: _lastNameTEController.text.trim(),
            mobile: _phoneTEController.text.trim(),
            photo: photo
          );
          await AuthController.saveUserDate(userData);
        }
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainBottomNavScreen(),
              ),
              (route) => false);
        }
        setState(() {});
      }else{
        if(!mounted){
          return;
        }
        setState(() {});
        showSnackBarMessage(context, 'Update Profile Failed! Try Again');
      }
    }
}

  IconButton togglePassword() {
    return IconButton(
      onPressed: () {
        _isObsecureText = !_isObsecureText;
        setState(() {});
      },
      icon: Icon(_isObsecureText ? Icons.visibility_off : Icons.visibility),
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
