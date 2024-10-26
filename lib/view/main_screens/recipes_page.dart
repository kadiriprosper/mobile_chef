import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/constants/helpers.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/model/network_model.dart';
import 'package:recipe_on_net/view/main_screens/widgets/custom_recipe_card.dart';
import 'package:recipe_on_net/view/main_screens/widgets/custom_recipe_chip.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  int resultsCount = 20;
  int selectedIndex = 0;
  bool isLoading = false;
  RecipeController recipeController = Get.put(RecipeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Recipes',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: recipeController.getCategoryData(
          category: categoryEmojiMap.entries.elementAt(selectedIndex).key,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data?.entries.first.key == AccessCondition.good) {
            resultsCount = snapshot
                    .data?[AccessCondition.good]?.entries.first.value!.length ??
                0;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        categoryEmojiMap.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomRecipeFilterChip(
                            label:
                                categoryEmojiMap.entries.elementAt(index).key,
                            leading: Text(
                              categoryEmojiMap.entries.elementAt(index).value,
                            ),
                            isLoading: (snapshot.data?[AccessCondition.good]
                                        ?.entries.first.key !=
                                    categoryEmojiMap.entries
                                        .elementAt(index)
                                        .key) &&
                                selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            selected: selectedIndex == index,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      //TODO: column left
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Found\n${(resultsCount / 2).floor() * 2} result(s)',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...List.generate((resultsCount / 2).floor(),
                                (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, right: 6),
                                child: CustomRecipeCard(
                                  addMargin: false,
                                  recipe: snapshot.data?[AccessCondition.good]
                                      ?.entries.first.value![index],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      //TODO: Column right
                      Expanded(
                        child: Column(
                          children: [
                            ...List.generate(
                              (resultsCount / 2).floor(),
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, left: 6),
                                child: CustomRecipeCard(
                                    addMargin: false,
                                    recipe: snapshot.data?[AccessCondition.good]
                                            ?.entries.first.value![
                                        (resultsCount / 2).floor() + index]
                                    // : snapshot.data!.entries.first.value![
                                    //     (resultsCount / 2).floor() +
                                    //         index -
                                    //         1],
                                    ),
                              ),
                            ),
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
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.data?.entries.first.key ==
                  AccessCondition.networkError) {
            return const Center(
              child: Icon(Icons.error_outline_outlined),
            );
          } else if (snapshot.hasError ||
              snapshot.hasData &&
                  snapshot.data?.entries.first.key == AccessCondition.error) {
            return const Center(
              child: Icon(Icons.error_outline_outlined),
            );
          }
          return const SpinKitFadingCube(
            color: Colors.brown,
            size: 20,
          );
        },
      ),
    );
  }
}
