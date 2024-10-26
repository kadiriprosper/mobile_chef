import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/model/recipe_down_model.dart';
import 'package:recipe_on_net/view/recipe_details_screen.dart';

class CustomRecipeCard extends StatelessWidget {
  const CustomRecipeCard({
    super.key,
    required this.recipe,
    this.addMargin,
  });

  final bool? addMargin;
  final RecipeDownModel? recipe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //TODOL Go to the recipe details screen
        if (recipe != null) {
          Get.to(
            () => RecipeDetailsScreen(mealId: recipe!.mealId),
          );
        }
      },
      child: Container(
        // height: 330,
        width: 200,
        margin: addMargin == false
            ? null
            : const EdgeInsets.all(5).copyWith(right: 15),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            ),
          ],
        ),
        child: recipe == null
            ? const Center(
                child: SpinKitFadingCube(
                  color: Colors.brown,
                  size: 12,
                ),
              )
            : Column(
                children: [
                  Container(
                    width: 250,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12).copyWith(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child: recipe?.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12).copyWith(
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            child: Image.network(
                              recipe!.image!,
                              fit: BoxFit.cover,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                return SizedBox(
                                  height: 200,
                                  width: 250,
                                  child: child,
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child:
                                      Icon(Icons.electrical_services_rounded),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress?.cumulativeBytesLoaded ==
                                    loadingProgress?.expectedTotalBytes) {
                                  return child;
                                }

                                return const SpinKitFadingCube(
                                  color: Colors.brown,
                                  size: 20,
                                );
                              },
                            ),
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    recipe!.mealName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipe!.mealId,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
