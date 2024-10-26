import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/controller/storage_controller.dart';
import 'package:recipe_on_net/controller/user_controller.dart';
import 'package:recipe_on_net/view/auth/login_screen.dart';
import 'package:recipe_on_net/view/main_screens/main_screen.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_button.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_text_form_field.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  File? profilePic;
  TextEditingController usernameController = Get.put(
    TextEditingController(),
    tag: 'profScrUsername',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
              ),
              const Text(
                'COMPLETE PROFILE SETUP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Setup a profile picture',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              ProfileImageCircle(
                isEditable: true,
                imagePath: profilePic?.path,
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
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Username',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomAuthTextFormField(
                    hintText: 'jimkay',
                    controller: usernameController,
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: false,
                    validator: (value) {
                      if (value != null && value.length >= 3) {
                        return null;
                      }
                      return 'Username length cannot be less than 3';
                    },
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              CustomAuthButton(
                onTap: () async {
                  if (usernameController.text.length >= 3) {
                    UserController userController = Get.put(UserController());
                    StorageController storageController =
                        Get.put(StorageController());
                    userController.setUserName(usernameController.text);
                    if (profilePic != null) {
                      final profileImgUrl =
                          await storageController.storeProfilePic(
                        profilePic!,
                        userController.userModel.value.email,
                      );
                      if (profileImgUrl != 'Error Setting profile pic') {
                        userController.setProfilePic(profileImgUrl);
                      }
                    }
                    final response = await storageController.storeUserData(
                      userController.userModel.value,
                    );
                    if (response == null) {
                      RecipeController recipeController =
                          Get.put(RecipeController(), permanent: true);
                      await recipeController.getRandomMeal();
                      Get.offUntil(
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                        (route) => false,
                      );
                    }
                  } else {
                    Get.showSnackbar(
                      const CustomSnackBar(
                        response: 'Username cannot be less than 3 characters',
                        backgroundColor: Color.fromARGB(255, 200, 19, 6),
                        title: 'Error',
                      ).build(context),
                    );
                  }
                },
                label: 'Continue',
                filled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImageCircle extends StatelessWidget {
  const ProfileImageCircle({
    super.key,
    required this.isEditable,
    this.onPressed,
    this.imagePath,
  });

  final bool isEditable;
  final String? imagePath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(500).copyWith(
          bottomRight: isEditable
              ? const Radius.circular(100)
              : const Radius.circular(500),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8,
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Container(
            width: 200,
            height: 200,
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 8,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Obx(() => ClipOval(
              child: userController.hasProfilePic()
                  ? FadeInImage.assetNetwork(
                    placeholder: 'assets/illustrations/food_bg_1.png',
                      image: userController.userModel.value.profilePic!,
                      fit: BoxFit.cover,
                    )
                  : imagePath == null
                      ? SvgPicture.asset(
                          'assets/illustrations/food_bg_1.svg',
                        )
                      : Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          //TODO: Put the error builder
                        ),
            ),),
          ),
          isEditable
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton.filled(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.orange.shade700,
                      ),
                    ),
                    iconSize: 24,
                    icon: const Icon(Icons.mode_edit_outline_outlined),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
