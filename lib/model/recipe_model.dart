import 'package:recipe_on_net/model/ingredient_model.dart';

class RecipeModel {
  RecipeModel({
    required this.id,
    required this.name,
    required this.category,
    required this.cookingInstructions,
    this.image,
    this.location,
    this.tags,
    this.youtubeLink,
  });
  String id;
  String name;
  String category;
  String cookingInstructions;
  String? image;
  String? location;
  String? tags;
  String? youtubeLink;
  IngredientModel? ingredients;

  factory RecipeModel.fromMap(Map<String, dynamic> data) {
    return RecipeModel(
      id: data['idMeal'],
      name: data['strMeal'],
      category: data['strCategory'],
      cookingInstructions: data['strInstructions'],
      image: data['strMealThumb'],
      location: data['strArea'],
      tags: data['strTags'],
      youtubeLink: data['strYoutube'],
    );
  }
}
