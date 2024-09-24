import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController usernameController = Get.put(
      TextEditingController(),
      tag: 'EditProfileUsername',
    );

    TextEditingController emailController = Get.put(
      TextEditingController(),
      tag: 'EditProfileEmail',
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBackButton(),
            const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
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
                  const SizedBox(height: 16),
                  CustomAuthTextFormField(
                    hintText: 'E-mail',
                    controller: emailController,
                    prefixIcon: Icon(
                      Icons.alternate_email_outlined,
                      color: Colors.orange.shade600,
                    ),
                    validator: (value) {
                      if (value != null && value.isEmail) {
                        return null;
                      }
                      return 'E-mail not valid';
                    },
                    filled: false,
                    textInputType: TextInputType.text,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ProfileCustomButton(
              onPressed: () {
                Get.to(
                  () => const ChangePasswordScreen(),
                );
              },
              label: 'Change Password',
            ),
            const SizedBox(height: 80),
            CustomAuthButton(
              onTap: () async {
                if (formKey.currentState?.validate() == true) {
                  //TODO: Save the user details
                  //TODO: GO BACK
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
