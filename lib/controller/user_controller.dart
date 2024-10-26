import 'package:get/get.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/controller/storage_controller.dart';
import 'package:recipe_on_net/model/message_model.dart';
import 'package:recipe_on_net/model/network_model.dart';
import 'package:recipe_on_net/model/recipe_model.dart';
import 'package:recipe_on_net/model/user_model.dart';

class UserController extends GetxController {
  late Rx<UserModel> userModel;
  StorageController storageController = Get.put(StorageController());
  RecipeController recipeController = Get.put(RecipeController());
  RxList<int> chatIndexToDelete = <int>[].obs;
  //  = UserModel(
  //   userName: '',
  //   email: '',
  // ).obs;

  bool? updateSuccess;

  Future<void> parseSavedRecipes() async {
    for (int i = 0; i < userModel.value.savedRecipe!.length; i++) {
      final meal = await recipeController.getMealDetails(
          mealId: userModel.value.savedRecipe![i].id);
      if (meal.entries.first.key == AccessCondition.good) {
        userModel.value.savedRecipe![i] = meal.entries.first.value!;
      }
    }
  }

  bool hasProfilePic() =>
      userModel.value.profilePic != null &&
      userModel.value.profilePic!.isNotEmpty;

  void setUserEmail(String email) {
    userModel = UserModel(
      userName: '',
      email: email,
    ).obs;
    // userModel.value.email = email;
  }

  void setProfilePic(String? picPath) {
    userModel.value.profilePic = picPath;
  }

  void setUserName(String userName) {
    userModel.value.userName = userName;
  }

  Future<void> updateChats(ChatModel chat) async {
    bool natureExists = false;
    for (int i = 0; i < userModel.value.savedChats!.length; i++) {
      if (userModel.value.savedChats![i].compareToOther(chat)) {
        userModel.value.savedChats![i] = chat;
        natureExists = true;
        break;
      }
    }
    if (!natureExists) {
      userModel.value.savedChats!.add(chat);
    }
    await saveUserDetailsToCloud();
  }

  Future<void> batchChatDelete() async {
    if (chatIndexToDelete.isNotEmpty) {
      for (var chatIndex in chatIndexToDelete) {
        userModel.value.savedChats!.removeAt(chatIndex);
      }
      chatIndexToDelete.clear();
      await saveUserDetailsToCloud();
    }
  }

  Future<void> updateSavedRecipe(RecipeModel recipe) async {
    for (var newRecipe in userModel.value.savedRecipe!) {
      if (newRecipe.id == recipe.id) {
        return;
      }
    }
    userModel.value.savedRecipe!.add(recipe);
    await saveUserDetailsToCloud();
  }

  Future<void> removeSavedRecipe(RecipeModel recipe) async {
    userModel.value.savedRecipe!.removeWhere(
      (element) => element.id == recipe.id,
    );
    await saveUserDetailsToCloud();
  }

  Future<String?> clearSavedRecipe() async {
    userModel.value.savedRecipe!.clear();
    final response = await saveUserDetailsToCloud();
    if (response == 'error') {
      return 'Error clearing recipes';
    }
    return null;
  }

  Future<String?> clearSavedChats() async {
    userModel.value.savedChats!.clear();
    final response = await saveUserDetailsToCloud();
    if (response == 'error') {
      return 'Error clearing chats';
    }
    return null;
  }

  Future<String?> saveUserDetailsToCloud() async {
    try {
      await storageController.storeUserData(
        userModel.value,
      );
      return null;
    } catch (_) {
      return 'error';
    }
  }
}
