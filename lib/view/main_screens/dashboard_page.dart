import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:recipe_on_net/constants/constants.dart';
import 'package:recipe_on_net/constants/enums.dart';
import 'package:recipe_on_net/constants/helpers.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/view/main_screens/widgets/dashboard_section_widget.dart';
import 'package:recipe_on_net/view/main_screens/widgets/large_recipe_card.dart';
import 'package:recipe_on_net/view/recipe_details_screen.dart';
import 'package:recipe_on_net/view/search_screen.dart';

Random randomMessage = Random(0);

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  RecipeController recipeController = Get.put(RecipeController());
  bool randomRecipeLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dashboardMessage[
                        randomMessage.nextInt(dashboardMessage.length)],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    emojiTimeOfDay(),
                    style: const TextStyle(fontSize: 50),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  text: 'Find the\n',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Best Recipes 😉 ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'here',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  Get.to(() => const SearchScreen());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 226, 226),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Iconsax.search_normal_outline,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 14),
                      Text(
                        'Search recipes',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Random Recipe',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: !randomRecipeLoading
                        ? () async {
                            randomRecipeLoading = true;
                            setState(() {});

                            await recipeController.getRandomMeal();
                            randomRecipeLoading = false;
                            setState(() {});
                          }
                        : null,
                    icon: const Icon(Iconsax.refresh_outline),
                    color: const Color.fromARGB(255, 255, 47, 0),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () => LargeRecipeCard(
                  recipe: recipeController.randomRecipe?.value,
                  onTap: () {
                    recipeController.selectedRecipe =
                        recipeController.randomRecipe?.value;
                    if (recipeController.selectedRecipe != null) {
                      Get.to(
                        () => RecipeDetailsScreen(
                          mealId: recipeController.selectedRecipe!.id,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              DashboardSectionWidget(
                onPressed: () {},
                sectionLabel: 'Beef Lovers',
                selectedCategory: DashboardSectionCategoryEnum.beef,
              ),
              const SizedBox(height: 24),
              DashboardSectionWidget(
                onPressed: () {},
                sectionLabel: 'Seafood Geng',
                selectedCategory: DashboardSectionCategoryEnum.seafood,
              ),
              const SizedBox(height: 24),
              DashboardSectionWidget(
                onPressed: () {},
                sectionLabel: 'Veggie Only',
                selectedCategory: DashboardSectionCategoryEnum.vegetarian,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
