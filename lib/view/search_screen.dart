import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:recipe_on_net/constants/constants.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/model/network_model.dart';
import 'package:recipe_on_net/view/main_screens/widgets/custom_recipe_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchController searchController = SearchController();
  RecipeController recipeController = Get.put(RecipeController());
  final futureKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: futureKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 70,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBackButton(),
            Text(
              'Search Recipes',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 15),
              SearchBar(
                autoFocus: true,
                elevation: const WidgetStatePropertyAll(0),
                controller: searchController,
                backgroundColor: WidgetStatePropertyAll(
                  Colors.grey.shade300,
                ),
                onSubmitted: (value) => setState(() {}),
                trailing: [
                  IconButton(
                    onPressed: searchController.text.isEmpty
                        ? null
                        : () {
                            // futureKey.currentState?.build(context);
                            setState(() {});
                          },
                    icon: const Icon(
                      Icons.send_outlined,
                    ),
                  ),
                ],
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                leading: const Icon(
                  Iconsax.search_normal_outline,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              //TODO: If it's empty display an enter recipe screen
              searchController.text.isEmpty
                  ? const SizedBox()
                  : FutureBuilder(
                      future: recipeController.searchMeal(
                          mealQuery: searchController.text),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data?.entries.first.key ==
                                AccessCondition.good) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  //TODO: column left
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Found\n${snapshot.data?[AccessCondition.good]?.length} result(s)',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ...List.generate(
                                          (snapshot.data![AccessCondition.good]!
                                                      .length /
                                                  2)
                                              .floor(),
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20, right: 6),
                                            child: CustomRecipeCard(
                                              addMargin: false,
                                              recipe: snapshot.data!.entries
                                                  .first.value![index],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //TODO: Column right

                                  Expanded(
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                          (snapshot.data![AccessCondition.good]!
                                                      .length /
                                                  2)
                                              .ceil(),
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20, left: 6),
                                            child: CustomRecipeCard(
                                              addMargin: false,
                                              recipe: snapshot.data!.entries
                                                  .first.value![(snapshot
                                                              .data![
                                                                  AccessCondition
                                                                      .good]!
                                                              .length /
                                                          2)
                                                      .floor() +
                                                  index],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data?.entries.first.key ==
                                AccessCondition.networkError) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.15,
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
                                snapshot.data?.entries.first.key ==
                                    AccessCondition.error) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.15,),
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Image.asset(
                                    'assets/illustrations/emptyCarton.png'),
                              ),
                            ),
                          );
                        }
                        // else if (snapshot.hasData &&
                        //     snapshot.data?.entries.first.key ==
                        //         AccessCondition.networkError) {
                        //   return const Center(
                        //     child: Icon(Icons.error_outline_outlined),
                        //   );
                        // } else if (snapshot.hasError ||
                        //     snapshot.hasData &&
                        //         snapshot.data?.entries.first.key ==
                        //             AccessCondition.error) {
                        //   return const Center(
                        //     child: Icon(Icons.error_outline_outlined),
                        //   );
                        // }
                        return const Padding(
                          padding: EdgeInsets.all(20),
                          child: SpinKitFadingCube(
                            color: Colors.brown,
                            size: 20,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (45 * pi) / 180,
      child: InkWell(
        onTap: () {
          Get.back();
        },
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
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
