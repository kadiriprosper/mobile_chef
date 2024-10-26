import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipe_on_net/model/recipe_model.dart';

class LargeRecipeCard extends StatelessWidget {
  const LargeRecipeCard({
    super.key,
    required this.onTap,
    required this.recipe,
  });

  final VoidCallback onTap;
  final RecipeModel? recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(3, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: BorderRadius.circular(12).copyWith(
                  topRight: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
              child: recipe?.image != null || recipe?.image != 'null'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12).copyWith(
                        topRight: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                      child: Image.network(
                        recipe!.image!,
                        fit: BoxFit.fitWidth,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.electrical_services_rounded),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress?.cumulativeBytesLoaded !=
                              loadingProgress?.expectedTotalBytes) {
                            return const SpinKitFadingCube(
                              color: Colors.brown,
                              size: 20,
                            );
                          }
                          return child;
                        },
                      ),
                    )
                  : const SizedBox(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '${recipe?.location} Dish',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      recipe?.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      recipe?.cookingInstructions ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
