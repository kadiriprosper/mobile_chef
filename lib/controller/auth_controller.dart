import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:recipe_on_net/constants/constants.dart';
import 'package:recipe_on_net/model/auth_model.dart';
import 'package:recipe_on_net/model/network_model.dart';

class AuthController extends GetxController {
  AuthModel authModel = AuthModel();
  final storage = const FlutterSecureStorage();

  Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
    final response = await authModel.userLoginUpWithEmail(
      email: email,
      password: password,
    );
    if (response.entries.first.key == AccessCondition.good) {
      await storage.write(
        key: emailDB,
        value: email,
      );
      return null;
    }
    return response.entries.first.value;
  }

  Future<String?> registerUser({
    required String email,
    required String password,
  }) async {
    final response = await authModel.userSignUpWithEmail(
      email: email,
      password: password,
    );
    if (response.entries.first.key == AccessCondition.good) {
      return await signInUser(
        email: email,
        password: password,
      );
    }
    return response.entries.first.value;
  }

  Future<String?> signInUserWithGoogle() async {
    final response = await authModel.signInWithGoogle();
    if (response.entries.first.key == AccessCondition.good) {
      await storage.write(
        key: emailDB,
        value: (response.entries.first.value as UserCredential).user?.email,
      );
      return null;
    }
    return response.entries.first.value;
  }

  Future<String?> sendPasswordResetEmail({required String email}) async {
    final response = await authModel.sendPasswordResetMail(email: email);
    if (response.entries.first.key == AccessCondition.good) {
      return null;
    }
    return response.entries.first.value;
  }

  Future<String?> resetUserPassword(
      {required String code, required String newPassword}) async {
    final response = await authModel.confirmPassworCode(
      code: code,
      newPassword: newPassword,
    );
    if (response.entries.first.key == AccessCondition.good) {
      return null;
    }
    return response.entries.first.value;
  }

  Future<String?> changeUserPassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    final response = await authModel.changeUserPassword(
      email: email,
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
    if (response.entries.first.key == AccessCondition.good) {
      return null;
    }
    return response.entries.first.value;
  }

  Future<String?> deleteUserAccount({
    required String password,
    required String email,
  }) async {
    final response = await authModel.deleteUserAccount(
      email: email,
      password: password,
    );
    if (response.entries.first.key == AccessCondition.good) {
      await storage.delete(
        key: emailDB,
      );
      return null;
    }
    return response.entries.first.value;
  }

  Future<String?> signOutUser() async {
    final response = await authModel.userSignOut();
    if (response.entries.first.key == AccessCondition.good) {
      await storage.delete(
        key: emailDB,
      );
      return null;
    }
    return response.entries.first.value;
  }
}
