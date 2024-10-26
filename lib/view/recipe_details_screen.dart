import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/controller/user_controller.dart';
import 'package:recipe_on_net/model/network_model.dart';
import 'package:recipe_on_net/model/recipe_model.dart';
import 'package:recipe_on_net/view/search_screen.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key, required this.mealId});

  final String mealId;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  bool? isFavorite;
  Widget recipeDetailsScreen = const Stack();
  RecipeModel? currentRecipe;
  RecipeController recipeController = Get.put(RecipeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: recipeController.getMealDetails(mealId: widget.mealId),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data?.entries.first.key == AccessCondition.good) {
                UserController userController = Get.put(UserController());
                currentRecipe = snapshot.data!.entries.first.value!;
                isFavorite = recipeController.isFavouriteRecipe(
                  snapshot.data!.entries.first.value!,
                  userController.userModel.value.savedRecipe!,
                );
                recipeDetailsScreen = SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      AspectRatio(
                        aspectRatio: 5 / 3,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 5,
                              ),
                              BoxShadow(
                                color: Colors.white70,
                                blurRadius: 8,
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              image:
                                  snapshot.data!.entries.first.value?.image !=
                                          null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data!.entries.first.value!
                                                .image!,
                                          ),
                                          fit: BoxFit.contain,
                                        )
                                      : null,
                              // borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8)
                            .copyWith(bottom: 30),
                        padding: const EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 8,
                            ),
                            BoxShadow(
                              color: Colors.white60,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${snapshot.data!.entries.first.value?.location} Recipe',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    snapshot.data!.entries.first.value
                                            ?.category ??
                                        '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                snapshot.data!.entries.first.value?.name ?? '',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Ingredients',
                                style: TextStyle(
                                  color: Color.fromARGB(174, 0, 0, 0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...List.generate(
                                snapshot.data!.entries.first.value?.ingredients
                                        .length ??
                                    0,
                                (index) => Row(
                                  children: [
                                    Text(
                                      snapshot.data!.entries.first.value!
                                          .ingredients[index].name.capitalize!,
                                      style: const TextStyle(
                                        color: Color.fromARGB(160, 94, 35, 6),
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Divider(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Text(
                                      snapshot.data!.entries.first.value!
                                              .ingredients[index].measure ??
                                          '',
                                      style: const TextStyle(
                                        color: Color.fromARGB(150, 94, 35, 6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Preparation Instructions',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                // '• ${snapshot.data!.entries.first.value?.cookingInstructions.replaceAll('\n', '').replaceAll(RegExp(r"\d\."), "").replaceAll('.', '.\n ').trim() ?? ''}',
                                '${snapshot.data!.entries.first.value?.formatedCookingInstructions}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tags: ${snapshot.data!.entries.first.value?.tags}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData &&
                  snapshot.data?.entries.first.key ==
                      AccessCondition.networkError) {
                recipeDetailsScreen = const Center(
                  child: Icon(Icons.error_outline_outlined),
                );
              } else if (snapshot.hasError ||
                  snapshot.hasData &&
                      snapshot.data?.entries.first.key ==
                          AccessCondition.error) {
                recipeDetailsScreen = const Center(
                  child: Icon(Icons.error_outline_outlined),
                );
              } else {
                recipeDetailsScreen = const Center(
                  child: SpinKitFadingCube(
                    color: Colors.brown,
                    size: 20,
                  ),
                );
              }
              return Stack(
                children: [
                  recipeDetailsScreen,
                  Positioned(
                    top: 20,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: [
                        const CustomBackButton(),
                        const Spacer(),
                        Transform.rotate(
                          angle: (45 * pi) / 180,
                          child: InkWell(
                            onTap: isFavorite != null
                                ? () async {
                                    UserController userController = Get.put(
                                      UserController(),
                                    );
                                    if (isFavorite == false) {
                                      userController
                                          .updateSavedRecipe(currentRecipe!);
                                      isFavorite = true;
                                    } else {
                                      userController
                                          .removeSavedRecipe(currentRecipe!);
                                      isFavorite = false;
                                    }
                                    setState(() {});
                                  }
                                : null,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              child: Transform.rotate(
                                angle: -(45 * pi) / 180,
                                child: isFavorite ?? false
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite,
                                        color:
                                            Color.fromARGB(255, 218, 218, 218),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
