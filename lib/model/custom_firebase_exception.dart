import 'package:firebase_auth/firebase_auth.dart';

///This class contains the exceptions that can be called by both firebase
///cloud firestore and firebase auth
class CustomFirebaseException {
  static String getFirebaseAuthException(
    FirebaseAuthException e,
    String defaultMessage,
  ) {
    switch (e.code) {
      case "user-not-found":
        return "User account does not exist";
      case "invalid-email":
        return "Check your email and try again";
      case "auth/user-not-found":
        return "User account does not exist";
      case "auth/invalid-email":
        return "Check your email and try again";
      case 'network-request-failed':
        return "Check your network and try again";
      case 'account-exists-with-different-credential':
        return 'Account already exists with different credential';
      case 'invalid-credential':
      case "wrong-password":
        return "Email or password is incorrect";
      case "expired-action-code":
        return "OTP has expired, please try again";
      case "invalid-action-code":
        return "OTP is incorrect, please try again";
      case "weak-password":
        return "Weak password: Please use a mix of alphanumeric characters";
      case "email-already-in-use":
        return "Email is already in use";
      default:
        return defaultMessage;
    }
  }

//   static String getFirebaseCloudStoreException(
//      e,
//     String defaultMessage,
//   ) {
//     switch (e.code) {
//       case "user-not-found":
//         return "User account does not exist";
//       case "invalid-email":
//         return "Check your email and try again";
//       case 'network-request-failed':
//         return "Check your network and try again";
//       case 'account-exists-with-different-credential':
//         return 'Account already exists with different credential';
//       case 'invalid-credential':
//         return 'Invalid Credentials';
//       case "wrong-password":
//         return "Email or password is incorrect";
//       case "weak-password":
//         return "Weak password: Please use a mix of alphanumeric characters";
//       case "email-already-in-use":
//         return "Email is already in use";
//       default:
//         return defaultMessage;
//     }
//   }
}
