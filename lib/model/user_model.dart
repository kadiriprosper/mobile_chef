import 'package:recipe_on_net/model/recipe_model.dart';

class UserModel {
  UserModel({
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.savedRecipe = const [],
  });
  String userName;
  String email;
  String firstName;
  String lastName;
  List<RecipeModel> savedRecipe;
}
