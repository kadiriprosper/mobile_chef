import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:recipe_on_net/view/main_screens/dashboard_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchController searchController = SearchController();
  int resultsCount = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBackButton(),
            const Text(
              'Search Recipes',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
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
              Column(
                children: [
                  Row(
                    children: [
                      //TODO: column left
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Found\n$resultsCount result(s)',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...List.generate(
                              (resultsCount / 2).floor(),
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, right: 6),
                                child: CustomRecipeCard(
                                  addMargin: false,
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
                              (resultsCount / 2).ceil(),
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, left: 6),
                                child: CustomRecipeCard(
                                  addMargin: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
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
