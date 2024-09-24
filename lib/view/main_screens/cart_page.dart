import 'package:flutter/material.dart';
import 'package:recipe_on_net/view/main_screens/dashboard_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Saved Recipes',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ...List.generate(
              10,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LargeRecipeCard(),
              ),
            ),
            const SizedBox(height: 20),
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
    );
  }
}
