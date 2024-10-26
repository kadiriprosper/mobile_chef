import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/controller/auth_controller.dart';
import 'package:recipe_on_net/controller/user_controller.dart';
import 'package:recipe_on_net/view/auth/login_screen.dart';
import 'package:recipe_on_net/view/search_screen.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_button.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_text_form_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = Get.put(
    TextEditingController(),
    tag: 'OldPassword',
  );
  TextEditingController newPasswordController = Get.put(
    TextEditingController(),
    tag: 'ChangePassword',
  );
  TextEditingController confirmNewPasswordController = Get.put(
    TextEditingController(),
    tag: 'ConfirmChangePassword',
  );

  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmNewPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: CustomBackButton(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Change Your Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  'assets/illustrations/forgot_password_img.png',
                ),
              ),
              const SizedBox(height: 45),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 14),
                    CustomAuthTextFormField(
                      hintText: 'Current Password',
                      controller: oldPasswordController,
                      prefixIcon: Icon(
                        Icons.lock_open_outlined,
                        color: Colors.orange.shade600,
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.length >= 8) {
                            return null;
                          }
                          return 'Password length cannot be less than 8';
                        }
                        return 'Please input a valid password';
                      },
                      textInputType: TextInputType.visiblePassword,
                      obscureText: obscureOldPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureOldPassword = !obscureOldPassword;
                          });
                        },
                        icon: obscureOldPassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 14),
                    CustomAuthTextFormField(
                      hintText: 'New Password',
                      controller: newPasswordController,
                      prefixIcon: Icon(
                        Icons.lock_open_outlined,
                        color: Colors.orange.shade600,
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.length >= 8) {
                            return null;
                          }
                          return 'Password length cannot be less than 8';
                        }
                        return 'Please input a valid password';
                      },
                      textInputType: TextInputType.visiblePassword,
                      obscureText: obscureNewPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureNewPassword = !obscureNewPassword;
                          });
                        },
                        icon: obscureNewPassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 14),
                    CustomAuthTextFormField(
                      hintText: 'Confirm New Password',
                      controller: confirmNewPasswordController,
                      prefixIcon: Icon(
                        Icons.lock_open_outlined,
                        color: Colors.orange.shade600,
                      ),
                      validator: (value) {
                        if (value != null &&
                            value == newPasswordController.value.text) {
                          return null;
                        }
                        return 'Password does not match';
                      },
                      textInputType: TextInputType.visiblePassword,
                      obscureText: obscureConfirmNewPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureConfirmNewPassword =
                                !obscureConfirmNewPassword;
                          });
                        },
                        icon: obscureConfirmNewPassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomAuthButton(
                      onTap: () async {
                        AuthController authController = Get.put(
                          AuthController(),
                        );
                        UserController userController = Get.put(
                          UserController(),
                        );
                        //TODO: show a snackbar to show status

                        final response = await Get.showOverlay(
                          asyncFunction: () =>
                              authController.changeUserPassword(
                            newPassword: newPasswordController.text,
                            email: userController.userModel.value.email,
                            oldPassword: oldPasswordController.text,
                          ),
                          loadingWidget: const SpinKitFadingCube(
                            color: Colors.brown,
                            size: 20,
                          ),
                        );
                        if (response == null) {
                          Get.showSnackbar(
                            const CustomSnackBar(
                              response: 'Password successfully changed',
                              backgroundColor: Colors.green,
                              title: 'Success',
                            ).build(context),
                          );
                        } else {
                          Get.showSnackbar(
                            CustomSnackBar(
                              response: response,
                              backgroundColor:
                                  const Color.fromARGB(255, 200, 19, 6),
                              title: 'Error',
                            ).build(context),
                          );
                        }
                        Get.back();
                      },
                      label: 'Change Password',
                      filled: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
