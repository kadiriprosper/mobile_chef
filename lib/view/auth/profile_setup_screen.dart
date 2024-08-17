import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_button.dart';
import 'package:recipe_on_net/view/widgets/custom_auth_text_form_field.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(500).copyWith(
                    bottomRight: const Radius.circular(100),
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
                      child: ClipOval(
                        child: SvgPicture.asset(
                          'assets/illustrations/food_bg_1.svg',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton.filled(
                        onPressed: () {
                          //TODO: Oppen image selection file
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.orange.shade700,
                          ),
                        ),
                        iconSize: 24,
                        icon: const Icon(Icons.mode_edit_outline_outlined),
                      ),
                    ),
                  ],
                ),
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
                onTap: () {},
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
