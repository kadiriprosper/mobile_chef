import 'package:get/get.dart';
import 'package:recipe_on_net/controller/auth_controller.dart';
import 'package:recipe_on_net/controller/global_controller.dart';
import 'package:recipe_on_net/controller/message_controller.dart';
import 'package:recipe_on_net/controller/recipe_controller.dart';
import 'package:recipe_on_net/controller/storage_controller.dart';
import 'package:recipe_on_net/controller/user_controller.dart';

final authController = Get.put<AuthController>(
  AuthController(),
  permanent: true,
);
final globalController = Get.put<GlobalController>(
  GlobalController(),
  permanent: true,
);
final messageController = Get.put<MessageController>(
  MessageController(),
  permanent: true,
);
final recipeController = Get.put<RecipeController>(
  RecipeController(),
  permanent: true,
);
final storageController = Get.put<StorageController>(
  StorageController(),
  permanent: true,
);

final userController = Get.put<UserController>(
  UserController(),
  permanent: true,
);
