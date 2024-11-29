import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/controller/controllers.dart';

import 'package:recipe_on_net/view/main_screens/widgets/large_recipe_card.dart';
import 'package:recipe_on_net/view/recipe_details_screen.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Saved Recipes',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(
        () => userController.userModel.value.savedRecipe!.isNotEmpty
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Obx(
                  () => Column(
                    children: [
                      ...List.generate(
                        userController.userModel.value.savedRecipe!.length,
                        (index) => Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: LargeRecipeCard(
                              recipe: userController
                                  .userModel.value.savedRecipe![index],
                              onTap: () {
                                Get.to(
                                  () => RecipeDetailsScreen(
                                    mealId: userController
                                        .userModel.value.savedRecipe![index].id,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Last Recipe',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: SvgPicture.asset(
                        'assets/illustrations/empty_basket.svg',
                        // color: Colors.orange,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        // colorFilter: const ColorFilter.mode(
                        //   Colors.orangeAccent,
                        //   BlendMode.srcIn,
                        // ),
                      ),
                    ),
                    Text(
                      'Yikes!!😱',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontFamily: 'Klasik',
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'No Currently Saved Recipe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontFamily: 'Klasik',
                      ),
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      onPressed: () {
                        globalController.currentIndex.value = 1;
                      },
                      height: 50,
                      minWidth: 100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.black87,
                      child: Text(
                        'Check Recipes',
                        style: TextStyle(
                          color: Colors.orangeAccent.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
