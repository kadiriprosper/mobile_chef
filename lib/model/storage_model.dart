import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_on_net/model/network_model.dart';

class StorageModel {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<Map<AccessCondition, String?>> storeUserProfilePic({
    required File file,
    required String picName,
  }) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    try {
      final refUrl = await firebaseStorage
          .ref('profile-pictures')
          .child(picName)
          .putFile(file)
          .then(
            (ref) => ref.ref.getDownloadURL(),
          );

      return {AccessCondition.good: refUrl};
    }  catch (e) {
      return {AccessCondition.error: 'Error Setting profile pic'};
    } 
  }

  Future<Map<AccessCondition, String?>> storeData({
    required Map<String, dynamic> data,
    required String collectionPath,
    required String documentPath,
  }) async {
    try {
      await firebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .set(data);
      return {AccessCondition.good: null};
    } on FirebaseException catch (e) {
      print(e);
      return {AccessCondition.error: 'Error Setting profile pic'};
    }
  }

  Future<Map<AccessCondition, dynamic>> getData({
    required String collectionPath,
    required String documentPath,
  }) async {
    try {
      final response = await firebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .get();
      return {AccessCondition.good: response.data()};
    } on FirebaseException catch (e) {
      print(e);
      return {AccessCondition.error: e.code};
    }
  }

  // Future<Map<AccessCondition, dynamic>> userSignUpWithEmail({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return {AccessCondition.good: response};
  //   } on FirebaseAuthException catch (e) {
  //     String errorCase = CustomFirebaseException.getFirebaseAuthException(
  //       e,
  //       "Error creating user account",
  //     );

  //     return {AccessCondition.error: errorCase};
  //   } catch (e) {
  //     return {AccessCondition.error: 'Error Creating Account'};
  //   }
  // }
}
