import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_on_net/constants/enums.dart';
import 'package:recipe_on_net/controller/storage_controller.dart';
import 'package:recipe_on_net/controller/user_controller.dart';
import 'package:recipe_on_net/view/auth/login_screen.dart';
import 'package:recipe_on_net/view/auth/profile_setup_screen.dart';
import 'package:recipe_on_net/view/main_screens/profile_page.dart';
import 'package:recipe_on_net/view/profile_pages/change_password_screen.dart';
import 'package:recipe_on_net/view/search_screen.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_button.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_text_form_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? profilePic;

  final formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());

  TextEditingController usernameController = Get.put(
    TextEditingController(),
    tag: 'EditProfileUsername',
  );

  // TextEditingController emailController = Get.put(
  //   TextEditingController(),
  //   tag: 'EditProfileEmail',
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 70,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBackButton(),
            Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ProfileImageCircle(
              isEditable: true,
              imagePath: Get.put(UserController()).userModel.value.profilePic,
              onDeviceFilePath: profilePic?.path,
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                final tempFile = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                if (tempFile != null) {
                  setState(() {
                    profilePic = File(tempFile.path);
                  });
                }
              },
            ),
            const SizedBox(height: 40),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomAuthTextFormField(
                    hintText: 'Username',
                    controller: usernameController,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.orange.shade600,
                    ),
                    validator: (value) {
                      if (value != null && value.length > 2) {
                        return null;
                      }
                      return 'Username cannot be empty';
                    },
                    filled: false,
                    textInputType: TextInputType.text,
                  ),
                  // const SizedBox(height: 16),
                  // CustomAuthTextFormField(
                  //   hintText: 'E-mail',
                  //   controller: emailController,
                  //   prefixIcon: Icon(
                  //     Icons.alternate_email_outlined,
                  //     color: Colors.orange.shade600,
                  //   ),
                  //   validator: (value) {
                  //     if (value != null && value.isEmail) {
                  //       return null;
                  //     }
                  //     return 'E-mail not valid';
                  //   },
                  //   filled: false,
                  //   textInputType: TextInputType.text,
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ProfileCustomButton(
              onPressed: userController.userLoginType == LoginTypeEnum.email.toString() ?  () {
                Get.to(
                  () => const ChangePasswordScreen(),
                );
              } : null,
              label: 'Change Password',
            ),
            const SizedBox(height: 80),
            CustomAuthButton(
              onTap: () async {
                if (formKey.currentState?.validate() == true) {
                  
                  StorageController storageController = Get.put(
                    StorageController(),
                  );

                  userController.setUserName(usernameController.text);

                  final response = await Get.showOverlay(
                    asyncFunction: () async {
                      if (profilePic != null) {
                        final profileImgUrl =
                            await storageController.storeProfilePic(
                          profilePic!,
                          userController.userModel.value.email,
                        );
                        if (profileImgUrl != 'Error Setting profile pic') {
                          userController.setProfilePic(profileImgUrl);
                        }
                        userController.setProfilePic(
                          await storageController.storeProfilePic(
                            profilePic!,
                            userController.userModel.value.email,
                          ),
                        );
                      }
                      return await storageController.storeUserData(
                        userController.userModel.value,
                      );
                    },
                    loadingWidget: const SpinKitFadingCube(
                      color: Colors.brown,
                      size: 20,
                    ),
                  );
                  if (response == null) {
                    userController.updateSuccess = true;
                  } else {
                    userController.updateSuccess = false;
                  }
                  Get.back();
                }
              },
              label: 'Save Details',
              filled: true,
            ),
          ],
        ),
      ),
    );
  }
}
