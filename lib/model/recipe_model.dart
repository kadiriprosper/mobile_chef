import 'package:recipe_on_net/model/ingredient_model.dart';

class RecipeModel {
  RecipeModel({
    required this.id,
    required this.name,
    required this.category,
    required this.cookingInstructions,
    this.isFavourite = false,
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
  bool isFavourite;
  String? tags;
  String? youtubeLink;
  List<IngredientModel> ingredients = [];

  String get formatedCookingInstructions {
    return cookingInstructions
        .split('\n')
        .map(
          (element) => '${element.padLeft(3, '• ')}\n',
        )
        .join('•')
        .replaceAll('•• •', '')
        .replaceAll('•STEP', 'STEP')
        .replaceAll('•Step', 'STEP')
        .replaceRange(0, 1, '•${cookingInstructions[0]}');
  }

  void storeIngredients(Map<String, dynamic> data) {
    bool isNull = false;
    int i = 1;
    while (!isNull) {
      ingredients.add(
        IngredientModel(
          name: data['strIngredient$i'],
          measure: data['strMeasure$i'],
        ),
      );
      isNull = data['strIngredient${i + 1}'] == null ||
              data['strIngredient${i + 1}'] == ""
          ? true
          : false;
      i++;
    }
  }

  factory RecipeModel.fromMap(Map<String, dynamic> data) {
    final recipeModel = RecipeModel(
      id: data['idMeal'],
      name: data['strMeal'],
      category: data['strCategory'],
      cookingInstructions: data['strInstructions'],
      image: data['strMealThumb'],
      location: data['strArea'],
      tags: data['strTags'],
      youtubeLink: data['strYoutube'],
    );
    recipeModel.storeIngredients(data);
    return recipeModel;
  }

  Map<String, String> receipeToStorageMap() {
    return {
      "id": id,
      "name": name,
      "image": image ?? "null",
    };
  }

  factory RecipeModel.fromStorageMap(Map<String, dynamic> data) {
    return RecipeModel(
      id: data['id'],
      name: data['name'],
      category: '',
      cookingInstructions: '',
      image: data['image'],
    );
  }

  bool compareToOther(RecipeModel other) {
    return id == other.id;
  }
}
