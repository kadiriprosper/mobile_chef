class IngredientModel {
  IngredientModel({
    required this.name,
    this.measure,
  });
  String name;
  String? measure;

  factory IngredientModel.fromMap(Map<String, dynamic> data, int index){
    return IngredientModel(
      name: data['strIngredient$index'],
      measure: data['strMeasure$index'],
    );
  }

}
