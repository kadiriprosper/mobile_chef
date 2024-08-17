import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_button.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_text_form_field.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  const ForgottenPasswordScreen({super.key});

  @override
  State<ForgottenPasswordScreen> createState() =>
      _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  TextEditingController emailController = Get.put(
    TextEditingController(),
    tag: 'ForgotPasswordEmail',
  );

  TapGestureRecognizer onClickLogin = Get.put(
    TapGestureRecognizer()..onTap = () => Get.back(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton.filled(
                  onPressed: () {},
                  iconSize: 26,
                  style: ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(Size(38, 38)),
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.grey.shade200,
                    ),
                  ),
                  color: Colors.black,
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                // CircleAvatar(
                //   radius: 24,
                //   backgroundColor: Colors.grey.shade100,
                //   child: IconButton(onPressed: onPress, icon: icon),
                // ),
              ),
              const SizedBox(height: 20),
              Text(
                'FORGOT YOUR PASSWORD?',
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
                    const Text(
                      'Enter your registered email below to receive your password reset instruction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomAuthTextFormField(
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
                    const SizedBox(height: 20),
                    CustomAuthButton(
                      onTap: () {},
                      label: 'Send Reset Link',
                      filled: true,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: 'Remember password? ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Login',
                      recognizer: onClickLogin,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.orange.shade800,
                      ),
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
