import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/constants/constants.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/controller/storage_controller.dart';
import 'package:recipe_on_net/controller/user_controller.dart';
import 'package:recipe_on_net/model/network_model.dart';
import 'package:recipe_on_net/view/auth/login_screen.dart';
import 'package:recipe_on_net/view/main_screens/main_screen.dart';
import 'package:recipe_on_net/view/networt_error_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 0),
          () async {
            const storage = FlutterSecureStorage();
            final response = await storage.read(key: emailDB);
            if (response != null && response.isNotEmpty) {
              final networkResponse = await isNetworkAvailable();
              if (networkResponse) {
                //
                UserController userController = Get.put(
                  UserController(),
                  permanent: true,
                );
                userController.userLoginType =
                    await storage.read(key: loginTypeDB);
                //
                StorageController storageController = Get.put(
                  StorageController(),
                );
                //
                userController.setUserEmail(response);
                //
                final secondResponse =
                    await storageController.getUserData(response);
                //
                if (secondResponse != null) {
                  userController.userModel.value = secondResponse;
                  await userController.parseSavedRecipes();
                }
                //
                RecipeController recipeController = Get.put(RecipeController());
                //
                await recipeController.getRandomMeal();
                //
                Get.offUntil(
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                  (route) => false,
                );
              } else {
                Get.offUntil(
                  MaterialPageRoute(
                    builder: (context) => const NetwortErrorPage(),
                  ),
                  (route) => false,
                );
              }
            } else {
              Get.offUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            }
          },
        ),
        builder: (context, snapshot) {
          //TODO: Splash Screen
          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/illustrations/chef.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Mobile Chef',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: SpinKitFadingCube(
                  color: Colors.brown,
                  size: 20,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
