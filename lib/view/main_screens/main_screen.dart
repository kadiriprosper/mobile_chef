import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:recipe_on_net/controller/global_controller.dart';
import 'package:recipe_on_net/view/main_screens/ai_chef_page.dart';
import 'package:recipe_on_net/view/main_screens/cart_page.dart';
import 'package:recipe_on_net/view/main_screens/dashboard_page.dart';
import 'package:recipe_on_net/view/main_screens/profile_page.dart';
import 'package:recipe_on_net/view/main_screens/recipes_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalController globalController = Get.put(GlobalController());
  final pages = const [
    DashboardPage(),
    RecipesPage(),
    AiChefPage(),
    CartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[globalController.currentIndex.value]),
      bottomNavigationBar:Obx(() =>  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: globalController.currentIndex.value,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            globalController.currentIndex.value = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_outline),
            activeIcon: Icon(Iconsax.home_bold),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.book_outline),
            activeIcon: Icon(Iconsax.book_1_bold),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(TeenyIcons.robot),
            label: 'Ai Chef',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.bookmark_outline),
            activeIcon: Icon(Iconsax.bookmark_bold),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle_outline),
            activeIcon: Icon(Iconsax.profile_circle_bold),
            label: 'Profile',
          ),
        ],
      ),
    ),);
  }
}
