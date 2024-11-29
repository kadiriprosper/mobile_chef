import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  bool isLoading = false;

  List<GlobalKey> categoryRecipeKey = List.generate(
    categoryEmojiMap.length,
    (index) => GlobalKey(),
  );

  ScrollController categoryScrollController = ScrollController();
  RecipeController recipeController = Get.put(RecipeController());

  double getOffset(GlobalKey key) {
    if (key.currentContext != null) {
      RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(
        Offset(0, categoryScrollController.offset),
      );
      return position.dy;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          '${categoryEmojiMap.entries.elementAt(recipeController.selectedRecipesIndex.value).key} Recipes',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: recipeController.getCategoryData(
          category: categoryEmojiMap.entries
              .elementAt(recipeController.selectedRecipesIndex.value)
              .key,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data?.entries.first.key == AccessCondition.good) {
            resultsCount = snapshot
                    .data?[AccessCondition.good]?.entries.first.value!.length ??
                0;
            return SingleChildScrollView(
              controller: categoryScrollController,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(categoryEmojiMap.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomRecipeFilterChip(
                            widgetKey: categoryRecipeKey[index],
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
                                recipeController.selectedRecipesIndex.value ==
                                    index,
                            onTap: () {
                              setState(() {
                                recipeController.selectedRecipesIndex.value =
                                    index;
                                // categoryScrollController.animateTo(
                                //   getOffset(categoryRecipeKey[index]),
                                //   duration: const Duration(milliseconds: 300),
                                //   curve: Curves.easeIn,
                                // );
                              });
                            },
                            selected:
                                recipeController.selectedRecipesIndex.value ==
                                    index,
                          ),
                        );
                        // if (recipeController.selectedRecipesIndex.value ==
                        //     index) {
                        //   categoryScrollController.animateTo(
                        //     getOffset(categoryRecipeKey[index]),
                        //     duration: const Duration(milliseconds: 300),
                        //     curve: Curves.easeIn,
                        //   );
                        // }
                      }),
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
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.15,
                ),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: SvgPicture.asset(
                      'assets/illustrations/network_error.svg'),
                ),
              ),
            );
          } else if (snapshot.hasError ||
              snapshot.hasData &&
                  snapshot.data?.entries.first.key == AccessCondition.error) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.15,
                ),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset('assets/illustrations/emptyCarton.png'),
                ),
              ),
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
