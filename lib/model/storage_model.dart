import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_on_net/model/network_model.dart';

class StorageModel {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<Map<AccessCondition, String?>> storeUserProfilePic({
    required File file,
    required String picName,
  }) async {
    try {
      final refUrl = firebaseStorage.ref('profile-pictures');
      final downloadUrl = refUrl.child(picName).putData(file.readAsBytesSync());
      return {
        AccessCondition.good: await (await downloadUrl).ref.getDownloadURL()
      };
    } catch (e) {
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
    } on FirebaseException catch (_) {
      return {AccessCondition.error: 'Error Storing User Data'};
    }
  }

  Future<Map<AccessCondition, String?>> checkDataExistence(
      {required String email,
      required String collectionPath,
      required Map<String, dynamic> data}) async {
    try {
      final response =
          await firebaseFirestore.collection(collectionPath).doc(email).get();
      if (response.data()?.isEmpty != true) {
        return {AccessCondition.good: 'DATA EXIST'};
      } else {
        return await storeData(
          data: data,
          collectionPath: collectionPath,
          documentPath: email,
        );
      }
    } on Exception catch (_) {
      return {AccessCondition.error: 'Error Getting Data'};
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
      return {AccessCondition.error: e.code};
    }
  }

  Future<Map<AccessCondition, String?>> deleteData(
      {required String documentPath, required String collectionPath}) async {
    try {
      await firebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .delete();
      await firebaseStorage
          .ref('profile-pictures')
          .child(documentPath)
          .delete();
      return {AccessCondition.good: null};
    } on FirebaseException catch (_) {
      return {AccessCondition.error: 'Error Deleting User Data'};
    }
  }
}
