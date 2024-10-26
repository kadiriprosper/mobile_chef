import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:recipe_on_net/controller/auth_controller.dart';
import 'package:recipe_on_net/controller/global_controller.dart';
import 'package:recipe_on_net/controller/user_controller.dart';
import 'package:recipe_on_net/model/user_model.dart';
import 'package:recipe_on_net/view/auth/login_screen.dart';
import 'package:recipe_on_net/view/auth/profile_setup_screen.dart';
import 'package:recipe_on_net/view/profile_pages/edit_profile_page.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_text_form_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileImageCircle(
              isEditable: false,
            ),
            const SizedBox(height: 20),
            Obx(
              () => Text(
                userController.userModel.value.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              userController.userModel.value.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: () async {
                await Get.to(() => const EditProfilePage());
                if (userController.updateSuccess == true) {
                  Get.showSnackbar(
                    const CustomSnackBar(
                      response: 'Profile successfully updated',
                      backgroundColor: Colors.green,
                      title: 'Success',
                    ).build(context),
                  );
                } else if (userController.updateSuccess == false) {
                  Get.showSnackbar(
                    const CustomSnackBar(
                      response: 'Error updating user profile',
                      backgroundColor: Color.fromARGB(255, 200, 19, 6),
                      title: 'Error',
                    ).build(context),
                  );
                }
                userController.updateSuccess = null;
              },
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              height: 44,
              color: Colors.orange.shade800,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 40),
            ProfileCustomButton(
              label: 'Clear AI chats',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  enableDrag: true,
                  builder: (context) => CustomBottomSheet(
                    onTap: () async {
                      final response = await Get.showOverlay(
                        asyncFunction: () => userController.clearSavedChats(),
                        loadingWidget: const SpinKitFadingCube(
                          color: Colors.brown,
                          size: 20,
                        ),
                      );
                      Get.back();
                      if (response == null) {
                        Get.showSnackbar(
                          const CustomSnackBar(
                                  response: 'Chats Cleared Successfully',
                                  title: 'Success',
                                  backgroundColor: Colors.green)
                              .build(context),
                        );
                      } else {
                        Get.showSnackbar(
                          CustomSnackBar(
                            response: response,
                            title: 'Error',
                            backgroundColor: Colors.red,
                          ).build(context),
                        );
                      }
                    },
                    label: 'Clear AI Chats',
                    bottomSheetHeight: 230,
                    bodyText:
                        'Ýou are about to clear all the chats you\'ve had with the AI chef. Do you relly want to continue?',
                    borderColor: Colors.orange.shade800,
                    buttonColor: Colors.orange.shade800,
                    buttonTextColor: Colors.white,
                    buttonText: 'Continue',
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            ProfileCustomButton(
              label: 'Clear Saved Recipes',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  enableDrag: true,
                  builder: (context) => CustomBottomSheet(
                    onTap: () async {
                      final response = await Get.showOverlay(
                        asyncFunction: () => userController.clearSavedRecipe(),
                        loadingWidget: const SpinKitFadingCube(
                          color: Colors.brown,
                          size: 20,
                        ),
                      );
                      Get.back();
                      if (response == null) {
                        Get.showSnackbar(
                          const CustomSnackBar(
                                  response: 'Recipes Cleared Successfully',
                                  title: 'Success',
                                  backgroundColor: Colors.green)
                              .build(context),
                        );
                      } else {
                        Get.showSnackbar(
                          CustomSnackBar(
                            response: response,
                            title: 'Error',
                            backgroundColor: Colors.red,
                          ).build(context),
                        );
                      }

                      // Get.back();
                    },
                    label: 'Clear Saved Recipes',
                    bottomSheetHeight: 230,
                    bodyText:
                        'Ýou are about to clear all your saved recipes. Do you want to continue with this process?',
                    borderColor: Colors.orange.shade800,
                    buttonColor: Colors.orange.shade800,
                    buttonTextColor: Colors.white,
                    buttonText: 'Continue',
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  enableDrag: true,
                  builder: (context) => CustomBottomSheet(
                    onTap: () async {
                      AuthController authController = Get.put(AuthController());
                      final response = await authController.signOutUser();
                      if (response == null) {
                        Get.put(GlobalController()).currentIndex.value = 0;
                        userController.userModel.value = UserModel(
                          userName: '',
                          email: '',
                        );
                        Get.offUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    label: 'Log Out',
                    bottomSheetHeight: 230,
                    bodyText:
                        'Ýou are about to log out. Note that all your details stored on this device would be deleted also',
                    borderColor: Colors.red,
                    buttonColor: Colors.red,
                    buttonTextColor: Colors.white,
                    buttonText: 'Log Out',
                  ),
                );
              },
              minWidth: MediaQuery.of(context).size.width,
              height: 64,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 14),
            MaterialButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  enableDrag: true,
                  builder: (context) => CustomBottomSheet(
                    onTap: () async {
                      await Get.dialog(
                        DestructiveActionAlertDialog(
                          onConfirm: (String password) async {
                            AuthController authController =
                                Get.put(AuthController());
                            final response = await Get.showOverlay(
                              asyncFunction: () =>
                                  authController.deleteUserAccount(
                                password: password,
                                email: userController.userModel.value.email,
                              ),
                              loadingWidget: const SpinKitFadingCube(
                                color: Colors.brown,
                                size: 20,
                              ),
                            );
                            if (response == null) {
                              Get.put(
                                GlobalController(),
                              ).currentIndex.value = 0;
                              userController.userModel.value = UserModel(
                                userName: '',
                                email: '',
                              );
                              Get.offUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            } else {
                              Get.showSnackbar(
                                CustomSnackBar(
                                  response: response,
                                  title: 'Error',
                                  backgroundColor: Colors.red,
                                ).build(context),
                              );
                            }
                          },
                        ),
                      );
                      Get.back();
                    },
                    label: 'Delete your account',
                    bottomSheetHeight: 300,
                    bodyText:
                        'Woah hold up.\nYou are about to delete your account right now. Doing so would erase your details from this phone and the database.\nDo you want to continue?',
                    borderColor: Colors.red.shade800,
                    buttonColor: Colors.red.shade700,
                    buttonTextColor: Colors.white,
                    buttonText: 'Continue',
                  ),
                );
              },
              minWidth: MediaQuery.of(context).size.width,
              height: 64,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: const Text(
                'Delete Account',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}

class DestructiveActionAlertDialog extends StatelessWidget {
  const DestructiveActionAlertDialog({
    super.key,
    required this.onConfirm,
  });

  final Function(String password) onConfirm;

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = Get.put(
      TextEditingController(),
      tag: 'PasswordConfirmDeleteAction',
    );
    return AlertDialog(
      title: const Text(
        'Delete Account',
        style: TextStyle(color: Colors.white),
      ),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            const Text(
              'You are about to delete your account.\nThis would erase completely your information from the database.\nDo you really really want to do this.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 40),
            CustomAuthTextFormField(
              hintText: 'Password',
              controller: passwordController,
              prefixIcon: const Icon(Icons.key_outlined),
              validator: (value) {
                if (value != null && value.length >= 8) {
                  return null;
                }
                return 'Invalid password';
              },
              textInputType: TextInputType.visiblePassword,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      actions: [
        MaterialButton(
          onPressed: () {
            Get.back();
          },
          height: 50,
          color: Colors.white,
          textColor: Colors.black,
          child: const Text('Cancel'),
        ),
        MaterialButton(
          onPressed: () async {
            if (passwordController.text.length >= 8) {
              await onConfirm(passwordController.text);
            }
          },
          height: 50,
          color: Colors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
            ),
          ),
          textColor: Colors.white,
          child: const Text('Continue'),
        ),
      ],
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.label,
    required this.bodyText,
    required this.borderColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.buttonText,
    required this.onTap,
    this.bottomSheetHeight = 250,
  });

  final String label;
  final String bodyText;
  final Color borderColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final String buttonText;
  final VoidCallback onTap;
  final double bottomSheetHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: bottomSheetHeight,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8).copyWith(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close_outlined),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            bodyText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
              onPressed: onTap,
              height: 50,
              color: buttonColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                ),
              ),
              textColor: buttonTextColor,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCustomButton extends StatelessWidget {
  const ProfileCustomButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: MediaQuery.of(context).size.width,
      height: 64,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const Icon(Iconsax.arrow_right_3_outline)
        ],
      ),
    );
  }
}
