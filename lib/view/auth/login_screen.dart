import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/constants/enums.dart';
import 'package:recipe_on_net/controller/controllers.dart';
import 'package:recipe_on_net/view/auth/forgotten_password_screen.dart';
import 'package:recipe_on_net/view/auth/registration_screen.dart';
import 'package:recipe_on_net/view/main_screens/dashboard_page.dart';
import 'package:recipe_on_net/view/main_screens/main_screen.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_button.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_text_form_field.dart';
import 'package:recipe_on_net/view/widgets/custom_external_auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = Get.put(
    TextEditingController(),
    tag: 'LoginEmail',
  );
  TextEditingController passwordController = Get.put(
    TextEditingController(),
    tag: 'LoginPassword',
  );

  TapGestureRecognizer onTapRegister = Get.put(
    TapGestureRecognizer()
      ..onTap = () {
        Get.to(() => const RegistrationScreen());
      },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Already have an account?\nLogin',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomAuthTextFormField(
                    filled: false,
                    controller: emailController,
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
                    filled: false,
                    hintText: 'Password',
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
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomAuthButton(
              filled: true,
              label: 'Login',
              onTap: () async {
                if (formKey.currentState?.validate() == true) {
                  final response = await Get.showOverlay(
                    asyncFunction: () => authController.signInUser(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                    loadingWidget: const SpinKitFadingCube(
                      color: Colors.brown,
                      size: 20,
                    ),
                  );
                  if (response == null) {
                    userController.setUserEmail(emailController.text);
                    final secondResponse = await Get.showOverlay(
                        asyncFunction: () =>
                            storageController.getUserData(emailController.text),
                        loadingWidget: const SpinKitFadingCube(
                          color: Colors.brown,
                          size: 20,
                        ));
                    if (secondResponse != null) {
                      userController.userModel.value = secondResponse;
                      await Get.showOverlay(
                          asyncFunction: () =>
                              userController.parseSavedRecipes(),
                          loadingWidget: const SpinKitFadingCube(
                            color: Colors.brown,
                            size: 20,
                          ));
                    }

                    await Get.showOverlay(
                        asyncFunction: () => recipeController.getRandomMeal(),
                        loadingWidget: const SpinKitFadingCube(
                          color: Colors.brown,
                          size: 20,
                        ));

                    Get.offUntil(
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false,
                    );
                  } else {
                    Get.showSnackbar(
                      CustomSnackBar(
                        response: response,
                        backgroundColor: const Color.fromARGB(255, 200, 19, 6),
                        title: 'Error',
                      ).build(context),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Get.to(() => const ForgottenPasswordScreen());
                },
                borderRadius: BorderRadius.circular(8),
                splashColor: Colors.orangeAccent.shade200,
                splashFactory: InkSparkle.splashFactory,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'forgotten password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
                          final response = await Get.showOverlay(
                            asyncFunction: () =>
                                authController.signInUserWithGoogle(),
                            loadingWidget: const SpinKitFadingCube(
                              color: Colors.brown,
                              size: 20,
                            ),
                          );
                          if (response.entries.first.key != 'error') {
                            userController.setUserEmail(response['email']);
                            userController.setUserName(response['displayName']);
                            userController.userModel.value.profilePic =
                                response['photoUrl'];
                            final googleStoreResponse =
                                await userController.saveUserDetailsToCloud();
                            userController.userLoginType =
                                LoginTypeEnum.email.toString();
                            if (googleStoreResponse == 'DATA EXIST') {
                              Get.off(() => const MainScreen());
                            }
                            Get.offUntil(
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                              (route) => false,
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              response['error'],
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
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    recognizer: onTapRegister,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 230, 81, 0),
                      fontWeight: FontWeight.bold,
                    ),
                    text: 'Register',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    super.key,
    required this.response,
    required this.title,
    required this.backgroundColor,
  });

  final String? response;
  final Color backgroundColor;
  final String title;

  @override
  GetSnackBar build(BuildContext context) {
    return GetSnackBar(
        title: title,
        message: response,
        backgroundColor: backgroundColor,
        borderColor: Colors.white,
        borderRadius: 12,
        animationDuration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
        isDismissible: true,
        snackPosition: SnackPosition.TOP);
  }
}
