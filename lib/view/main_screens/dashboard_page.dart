import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:recipe_on_net/view/search_screen.dart';

enum DashboardSectionCategoryEnum {
  beef,
  vegetarians,
  seafood,
}

const timeOfDayEmoji = [
  '🔆',
  '☀️',
  '🌤️',
  '🌙',
  '🌚',
];

const dashboardMessage = [
  'howdy there 👋',
  'good day 😁',
  'hi there 😉',
];

Random randomMessage = Random(0);

String emojiTimeOfDay() {
  if (TimeOfDay.now().hour > 0 && TimeOfDay.now().hour <= 5) {
    return timeOfDayEmoji[0];
  } else if (TimeOfDay.now().hour > 5 && TimeOfDay.now().hour < 12) {
    return timeOfDayEmoji[1];
  } else if (TimeOfDay.now().hour >= 12 && TimeOfDay.now().hour < 17) {
    return timeOfDayEmoji[2];
  } else if (TimeOfDay.now().hour >= 17 && TimeOfDay.now().hour < 20) {
    return timeOfDayEmoji[3];
  } else {
    return timeOfDayEmoji[4];
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
                  //TODO: Change this to a list of welcome messages
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
                    onPressed: () {
                      // TODO: Refresh the random recipe
                    },
                    icon: const Icon(Iconsax.refresh_outline),
                    color: Colors.deepOrange.shade900,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LargeRecipeCard(),
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
                selectedCategory: DashboardSectionCategoryEnum.beef,
              ),
              const SizedBox(height: 24),
              DashboardSectionWidget(
                onPressed: () {},
                sectionLabel: 'Veggie Only',
                selectedCategory: DashboardSectionCategoryEnum.beef,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeRecipeCard extends StatelessWidget {
  const LargeRecipeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        //TODO: Go to recipe details screen
      },
      child: Container(
        height: 200,
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
        child: Row(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12).copyWith(
                  topRight: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'American Dish',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Lorem Ispum Food Pasta and Egg Dish and fish stain',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Lorem Ispum Food Pasta and Egg Dish and fish stain',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionLabel,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            MaterialButton(
              onPressed: onPressed,
              padding: const EdgeInsets.all(0),
              minWidth: 0,
              child: Text(
                'see all',
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
              (index) => CustomRecipeCard(),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomRecipeCard extends StatelessWidget {
  const CustomRecipeCard({
    super.key,
    this.addMargin,
  });

  final bool? addMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: 230,
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
      child: Column(
        children: [
          Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12).copyWith(
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Egg Pasta',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Spicy Chicken Pasta ',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
