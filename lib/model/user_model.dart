import 'package:recipe_on_net/model/ingredient_model.dart';
import 'package:recipe_on_net/model/recipe_model.dart';

class UserModel {
  UserModel({
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.cartedIngredients = const [],
    this.savedRecipe = const [],
    this.preferredColorHex = 0xFFFFFFFF,
  });
  String userName;
  String email;
  String firstName;
  String lastName;
  int preferredColorHex;
  List<RecipeModel> savedRecipe;
  List<IngredientModel> cartedIngredients;
}
