import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/constants/enums.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/model/network_model.dart';
import 'package:recipe_on_net/view/main_screens/widgets/custom_recipe_card.dart';

class DashboardSectionWidget extends StatelessWidget {
  const DashboardSectionWidget({
    super.key,
    required this.sectionLabel,
    required this.onPressed,
    required this.selectedCategory,
  });

  final String sectionLabel;
  final VoidCallback onPressed;
  final DashboardSectionCategoryEnum selectedCategory;

  @override
  Widget build(BuildContext context) {
    final recipeController = Get.put(RecipeController());
    return FutureBuilder(
        future:
            recipeController.getCategoryData(category: selectedCategory.name),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    sectionLabel,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  !snapshot.hasData
                      ? const SpinKitFadingCube(
                          color: Colors.brown,
                          size: 12,
                        )
                      : const SizedBox(),
                  const Spacer(),
                  MaterialButton(
                    onPressed: onPressed,
                    padding: const EdgeInsets.all(0),
                    minWidth: 0,
                    child: Text(
                      'see more',
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    5,
                    (index) => CustomRecipeCard(
                      recipe: snapshot.data?[AccessCondition.good]?.entries
                          .first.value?[index],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
