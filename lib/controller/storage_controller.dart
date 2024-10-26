import 'dart:io';

import 'package:get/get.dart';
import 'package:recipe_on_net/model/network_model.dart';
import 'package:recipe_on_net/model/storage_model.dart';
import 'package:recipe_on_net/model/user_model.dart';

class StorageController extends GetxController {
  StorageModel storageModel = StorageModel();

  Future<UserModel?> getUserData(String email) async {
    final response = await storageModel.getData(
      collectionPath: 'users',
      documentPath: email,
    );
    if (response.entries.first.key == AccessCondition.good) {
      return UserModel.fromMap(response.entries.first.value);
    } else {
      return null;
    }
  }

  Future<String?> storeProfilePic(File file, String email) async {
    final response = await StorageModel.storeUserProfilePic(
      file: file,
      picName: email,
    );
    
      return response.entries.first.value;
    
  }

  Future<String?> storeUserData(UserModel userModel) async {
    final response = await storageModel.storeData(
      data: {
        "last_update": DateTime.now().toString(),
        ...userModel.userToMap(),
      },
      collectionPath: 'users',
      documentPath: userModel.email,
    );
    if (response.entries.first.key == AccessCondition.good) {
      return null;
    } else {
      return response.entries.first.value;
    }
  }
}
