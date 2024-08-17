import 'package:flutter/material.dart';
import 'package:recipe_on_net/view/main_screens/dashboard_page.dart';

const categoryEmojiMap = {
  'Beef': '🥩',
  'Chicken': '🐔',
  'Dessert': '🍰',
  'Lamb': '🐑',
  'Pasta': '♨',
  'Pork': '🐖',
  'Seafood': '🦐',
  'Side Dish': '🥙',
  'Starter': '🍚',
  'Vegan': '🥦',
  'Vegetarian': '🥕',
  'Breakfast': '🍞',
  'Goat': '🐐',
  'Others': '🤷‍♀️',
};

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  int resultsCount = 20;
  int selectedIndex = 0;
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
      body: SingleChildScrollView(
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
                      label: categoryEmojiMap.entries.elementAt(index).key,
                      leading: Text(
                        categoryEmojiMap.entries.elementAt(index).value,
                      ),
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
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CustomRecipeCard(),
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
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CustomRecipeCard(),
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
      ),
    );
  }
}

class CustomRecipeFilterChip extends StatelessWidget {
  const CustomRecipeFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.leading,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Widget leading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected ? Colors.black : Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading,
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
    // FilterChip(
    //   label: Text(label),
    //   padding: const EdgeInsets.all(14),
    //   avatar: leading,
    //   selected: selected,
    //   selectedColor: Colors.orange.shade800,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     side: BorderSide.none,
    //   ),
    //   showCheckmark: false,
    //   onSelected: (_) => onTap,
    // );
  }
}
