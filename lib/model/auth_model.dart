import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe_on_net/model/custom_firebase_exception.dart';
import 'package:recipe_on_net/model/network_model.dart';

class AuthModel {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Map<AccessCondition, dynamic>> userSignUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {AccessCondition.good: response};
    } on FirebaseAuthException catch (e) {
      String errorCase = CustomFirebaseException.getFirebaseAuthException(
        e,
        "Error creating user account",
      );

      return {AccessCondition.error: errorCase};
    } catch (e) {
      return {AccessCondition.error: 'Error Creating Account'};
    }
  }

  Future<Map<AccessCondition, dynamic>> userLoginUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {AccessCondition.good: response};
    } on FirebaseAuthException catch (e) {
      String errorCase = CustomFirebaseException.getFirebaseAuthException(
        e,
        "Error logging you in",
      );

      return {AccessCondition.error: errorCase};
    } catch (e) {
      return {AccessCondition.error: 'Error logging you in'};
    }
  }

  Future<Map<AccessCondition, dynamic>> signInWithGoogle() async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      final response = await (await GoogleSignIn().signIn())?.authentication;
      if (response != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: response.accessToken,
          idToken: response.idToken,
        );
        final authResponse =
            await firebaseAuth.signInWithCredential(credential);
        return {AccessCondition.good: authResponse};
      }

      return {AccessCondition.error: 'Error Logging You In'};
    } on FirebaseAuthException catch (e) {
      String errorCase = CustomFirebaseException.getFirebaseAuthException(
        e,
        "Error logging you in",
      );

      return {AccessCondition.error: errorCase};
    } catch (e) {
      return {AccessCondition.error: 'Error logging you in'};
    }
  }

  Future<Map<AccessCondition, dynamic>> sendPasswordResetMail({
    required String email,
  }) async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return {AccessCondition.good: null};
    } on FirebaseAuthException catch (e) {
      String errorCase = CustomFirebaseException.getFirebaseAuthException(
        e,
        "Error sending password reset mail",
      );

      return {AccessCondition.error: errorCase};
    } catch (e) {
      return {AccessCondition.error: 'Error sending password reset mail'};
    }
  }

  Future<Map<AccessCondition, dynamic>> confirmPassworCode({
    required String code,
    required String newPassword,
  }) async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      await firebaseAuth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      return {AccessCondition.good: null};
    } on FirebaseAuthException catch (e) {
      String errorCase = CustomFirebaseException.getFirebaseAuthException(
        e,
        "Error confirming otp code",
      );

      return {AccessCondition.error: errorCase};
    } catch (e) {
      return {AccessCondition.error: 'Error confirming otp code'};
    }
  }

  Future<Map<AccessCondition, dynamic>> changeUserPassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      final response = await userLoginUpWithEmail(
        email: email,
        password: oldPassword,
      );
      if (response.entries.first.key == AccessCondition.good) {
        await firebaseAuth.currentUser?.updatePassword(newPassword);
        return {AccessCondition.good: null};
      }
      return {AccessCondition.error: response.entries.first.value};
    } on FirebaseAuthException catch (e) {
      String errorCase = CustomFirebaseException.getFirebaseAuthException(
        e,
        "Error changing user password",
      );

      return {AccessCondition.error: errorCase};
    } catch (e) {
      return {AccessCondition.error: 'Error changing user password'};
    }
  }

  Future<Map<AccessCondition, dynamic>> userSignOut() async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      await firebaseAuth.signOut();
      return {AccessCondition.good: null};
    } on FirebaseAuthException catch (e) {
      String errorCase = CustomFirebaseException.getFirebaseAuthException(
        e,
        "Cannot sign user out now",
      );

      return {AccessCondition.error: errorCase};
    } catch (e) {
      return {AccessCondition.error: 'Error signing user out'};
    }
  }

  Future<Map<AccessCondition, dynamic>> deleteUserAccount({
    required String email,
    required String password,
  }) async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      final response = await userLoginUpWithEmail(
        email: email,
        password: password,
      );
      if (response.entries.first.key == AccessCondition.good) {
        await firebaseAuth.currentUser?.delete();
      }
      return {AccessCondition.good: null};
    } on FirebaseAuthException catch (e) {
      String errorCase = CustomFirebaseException.getFirebaseAuthException(
        e,
        "Error deleting user account",
      );

      return {AccessCondition.error: errorCase};
    } catch (e) {
      return {AccessCondition.error: 'Error deleting user account'};
    }
  }
}
