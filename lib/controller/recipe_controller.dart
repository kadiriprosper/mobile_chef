import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/model/network_model.dart';
import 'package:recipe_on_net/model/recipe_down_model.dart';
import 'package:recipe_on_net/model/recipe_model.dart';

class RecipeController extends GetxController {
  Rx<RecipeModel>? randomRecipe;

  //TODO: TEST
  RxInt selectedRecipesIndex = 0.obs;
  

  RecipeModel? selectedRecipe;

  Map<String, List<RecipeDownModel>> categoryRecipes = {};

  NetworkModel networkModel = NetworkModel();

  Future<AccessCondition> getRandomMeal() async {
    final response = await networkModel.getMeal(
      '/random.php',
    );
    if (response.entries.first.key == AccessCondition.good) {
      randomRecipe = RecipeModel.fromMap(
        (response[AccessCondition.good]["meals"] as List).first,
      ).obs;
      return AccessCondition.good;
    } else if (response.entries.first.key == AccessCondition.networkError) {
      return AccessCondition.networkError;
    } else {
      return AccessCondition.error;
    }
  }

  Future<Map<AccessCondition, Map<String, List<RecipeDownModel>?>?>>
      getCategoryData({required String category}) async {
    if (categoryRecipes.containsKey(category)) {
      return {
        AccessCondition.good: {category: categoryRecipes[category]}
      };
    } else {
      final response = await networkModel.getMeal(
        '/filter.php?c=$category',
      );
      if (response.entries.first.key == AccessCondition.good) {
        List<RecipeDownModel> recipeList =
            (response[AccessCondition.good]["meals"] as List)
                .map(
                  (e) => RecipeDownModel.fromMap(e),
                )
                .toList();

        //Stores the data in a local variable
        categoryRecipes[category] = recipeList;
        return {
          AccessCondition.good: {category: recipeList}
        };
      } else if (response.entries.first.key == AccessCondition.networkError) {
        return {AccessCondition.networkError: null};
      } else {
        return {AccessCondition.error: null};
      }
    }
  }

  Future<Map<AccessCondition, List<RecipeDownModel>?>> searchMeal(
      {required String mealQuery}) async {
    final response = await networkModel.getMeal(
      '/search.php?s=$mealQuery',
    );
    if (response.entries.first.key == AccessCondition.good) {
      List<RecipeDownModel> recipeList =
          (response[AccessCondition.good]["meals"] as List)
              .map(
                (e) => RecipeDownModel.fromMap(e),
              )
              .toList();
      return {AccessCondition.good: recipeList};
    } else if (response.entries.first.key == AccessCondition.networkError) {
      return {AccessCondition.networkError: null};
    } else {
      return {AccessCondition.error: null};
    }
  }

  Future<Map<AccessCondition, RecipeModel?>> getMealDetails(
      {required String mealId}) async {
    final response = await networkModel.getMeal(
      '/lookup.php?i=$mealId',
    );
    if (response.entries.first.key == AccessCondition.good) {
      RecipeModel recipeList = RecipeModel.fromMap(
        (response[AccessCondition.good]["meals"] as List).first,
      );

      return {AccessCondition.good: recipeList};
    } else if (response.entries.first.key == AccessCondition.networkError) {
      return {AccessCondition.networkError: null};
    } else {
      return {AccessCondition.error: null};
    }
  }

  bool isFavouriteRecipe(RecipeModel recipe, List<RecipeModel> favouriteList) {
    for (var newRecipe in favouriteList) {
      if (recipe.id == newRecipe.id) {
        return true;
      }
    }
    return false;
  }
}
