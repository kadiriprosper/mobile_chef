class RecipeDownModel {
  const RecipeDownModel({
    required this.mealName,
    required this.mealId,
    this.image,
  });
  final String mealName;
  final String mealId;
  final String? image;

  factory RecipeDownModel.fromMap(Map<String, dynamic> data) {
    return RecipeDownModel(
      mealName: data['strMeal'],
      image: data['strMealThumb'],
      mealId: data['idMeal'],
    );
  }
}
