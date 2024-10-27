import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/controller/auth_controller.dart';
import 'package:recipe_on_net/controller/user_controller.dart';
import 'package:recipe_on_net/view/auth/login_screen.dart';
import 'package:recipe_on_net/view/auth/profile_setup_screen.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_button.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_text_form_field.dart';
import 'package:recipe_on_net/view/widgets/custom_external_auth_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool obscureText = true;
  bool obscureConfirmText = true;
  final formKey = GlobalKey<FormState>();

  TextEditingController userNameController = Get.put(
    TextEditingController(),
    tag: 'UserNamePassword',
  );
  TextEditingController emailController = Get.put(
    TextEditingController(),
    tag: 'ReigistrationEmail',
  );
  TextEditingController passwordController = Get.put(
    TextEditingController(),
    tag: 'RegistrationPassword',
  );
  TextEditingController confirmPasswordController = Get.put(
    TextEditingController(),
    tag: 'RegistrationConfirmPassword',
  );

  TapGestureRecognizer onTapLogin = Get.put(
    TapGestureRecognizer()
      ..onTap = () {
        Get.off(() => const LoginScreen());
      },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/illustrations/create_account_img.png',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'CREATE YOUR ACCOUNT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomAuthTextFormField(
                      controller: emailController,
                      filled: false,
                      hintText: 'E-mail',
                      prefixIcon: Icon(
                        Icons.alternate_email_outlined,
                        color: Colors.orange.shade600,
                      ),
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null && value.isEmail) {
                          return null;
                        }
                        return 'Enter valid email';
                      },
                    ),
                    const SizedBox(height: 8),
                    CustomAuthTextFormField(
                      hintText: 'Password',
                      filled: false,
                      controller: passwordController,
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
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: obscureText
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomAuthTextFormField(
                      hintText: 'Confirm Password',
                      filled: false,
                      controller: confirmPasswordController,
                      prefixIcon: Icon(
                        Icons.lock_open_outlined,
                        color: Colors.orange.shade600,
                      ),
                      validator: (value) {
                        if (value != null &&
                            value == passwordController.value.text) {
                          return null;
                        }
                        return 'Password does not match';
                      },
                      textInputType: TextInputType.visiblePassword,
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureConfirmText = !obscureConfirmText;
                          });
                        },
                        icon: obscureConfirmText
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CustomAuthButton(
                filled: true,
                label: 'Create Account',
                onTap: () async {
                  if (formKey.currentState?.validate() == true) {
                    AuthController authController = Get.put(AuthController());
                    UserController userController =
                        Get.put(UserController(), permanent: true);
                    userController.setUserEmail(emailController.text);
                    final response = await Get.showOverlay(
                      asyncFunction: () async {
                        final innerResponse = await authController.registerUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (innerResponse == null) {
                          userController.setUserName('anonymous');
                          final storageResponse =
                              await userController.saveUserDetailsToCloud();
                          if (storageResponse == null) {
                            return null;
                          } else {
                            await authController.deleteUserAccount(
                              password: passwordController.text,
                              email: emailController.text,
                            );
                            return 'Error creating user account';
                          }
                        }
                      },
                      loadingWidget: const SpinKitFadingCube(
                        color: Colors.brown,
                        size: 20,
                      ),
                    );
                    if (response == null) {
                      Get.off(() => const ProfileSetupScreen());
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
                  }
                },
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(width: 8),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 600,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomExternalAuthButton(
                        buttonLabel: 'Continue with Google',
                        icon: Image.asset(
                          'assets/icons/google_icon.png',
                          height: 36,
                          width: 36,
                        ),
                        onPressed: () async {
                          AuthController authController =
                              Get.put(AuthController());

                          final response = await Get.showOverlay(
                            asyncFunction: () =>
                                authController.signInUserWithGoogle(),
                            loadingWidget: const SpinKitFadingCube(
                              color: Colors.brown,
                              size: 20,
                            ),
                          );
                          if (response == null) {
                            Get.off(() => const ProfileSetupScreen());
                          } else {
                            Get.snackbar(
                              'Error',
                              response,
                              backgroundColor:
                                  const Color.fromARGB(255, 93, 27, 22),
                              colorText: Colors.white,
                              borderColor: Colors.white,
                              margin: const EdgeInsets.all(20),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      recognizer: onTapLogin,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 230, 81, 0),
                        fontWeight: FontWeight.bold,
                      ),
                      text: 'Login',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
