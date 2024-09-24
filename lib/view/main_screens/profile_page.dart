import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:recipe_on_net/view/auth/profile_setup_screen.dart';
import 'package:recipe_on_net/view/profile_pages/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            ProfileImageCircle(
              isEditable: false,
            ),
            const SizedBox(height: 20),
            Text(
              'User Name',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'usermail',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: () {
                Get.to(
                  () => const EditProfilePage(),
                );
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
                    onTap: () {
                      //TODO: Clear AI chats
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
                    onTap: () {
                      //TODO: Clear saved  recipes
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
                    onTap: () {
                      //TODO: Log out the user
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
                        const DestructiveActionAlertDialog(),
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
              child: Text(
                'Delete Account',
                style: const TextStyle(
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
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Account',
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        'You are about to delete your account.\nThis would erase completely your information from the database.\nDo you really really want to do this.',
        style: TextStyle(color: Colors.white),
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
          onPressed: () {
            //TODO: Delete the user's account
          },
          height: 50,
          color: Colors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
            ),
          ),
          textColor: Colors.white,
          child: Text('Continue'),
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
