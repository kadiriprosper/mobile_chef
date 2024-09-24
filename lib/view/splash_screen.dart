import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/view/auth/login_screen.dart';
import 'package:recipe_on_net/view/onboarding/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 3),
          () {
            Get.to(() => const LoginScreen());
          },
        ),
        builder: (context, snapshot) {
          //TODO: Splash Screen
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              //TODO: Change the text to the logo later
              Text(
                'Mobile Chef',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 20),
              SpinKitFadingCube(
                color: Colors.brown,
                size: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
