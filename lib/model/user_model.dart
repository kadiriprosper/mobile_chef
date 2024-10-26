import 'package:get/get.dart';
import 'package:recipe_on_net/model/message_model.dart';
import 'package:recipe_on_net/model/recipe_model.dart';

class UserModel {
  UserModel({
    required this.userName,
    required this.email,
    this.fromCloud = false,
    this.profilePic,
    this.savedChats,
    this.savedRecipe,
  });
  String userName;
  String email;
  String? profilePic;
  bool fromCloud;
  RxList<RecipeModel>? savedRecipe = <RecipeModel>[].obs;
  RxList<ChatModel>? savedChats = <ChatModel>[].obs;

  Map<String, dynamic> userToMap() {
    return {
      "username": userName,
      "email": email,
      "profile_pic": profilePic,
      "from_cloud": true,
      "saved_recipe": [
        ...savedRecipe!.map(
          (recipe) => recipe.receipeToStorageMap(),
        ),
      ],
      "saved_chats": [
        ...savedChats!.map(
          (chats) => chats.chatToStorageModel(),
        ),
      ]
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    final userModel = UserModel(
      userName: data['username'],
      email: data['email'],
      fromCloud: data['from_cloud'] ?? false,
      profilePic: data['profile_pic'],
    );

    final recipeList = data['saved_recipe'] as List;
    final recipeHolder = recipeList
        .map(
          (element) => RecipeModel.fromStorageMap(element),
        )
        .toList();
    userModel.savedRecipe = recipeHolder.obs;
    final chatList = data['saved_chats'] as List;
    final chatHolder = chatList
        .map(
          (element) => ChatModel.fromStorageModel(element),
        )
        .toList();
    userModel.savedChats = chatHolder.obs;
    return userModel;
  }
}
