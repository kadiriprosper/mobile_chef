import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/firebase_options.dart';
import 'package:recipe_on_net/view/chat_pages/chat_screen.dart';
import 'package:recipe_on_net/view/networt_error_page.dart';
import 'package:recipe_on_net/view/splash_screen.dart';

const geminAPIToken = String.fromEnvironment("gemini_api_key");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: geminAPIToken);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // await Get.put(RecipeController()).getRandomMeal();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFFFF3E9),
      ),
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
