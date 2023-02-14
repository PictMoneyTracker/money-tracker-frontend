
import 'package:firebase_auth/firebase_auth.dart';

import '../../api_layer/api_response.dart';
import '../../logger/my_logger.dart';

class FirebaseEmailPasswordAuthService {
  final MyLogger myLogger = MyLogger.getInstance;
  Future<ApiResponse<bool>> signUp(String email, password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const ApiResponse(data: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        myLogger.logMessage('weak password');
      } else if (e.code == 'email-already-in-use') {
        myLogger.logMessage('The account already exists for that email.');
      }
      return ApiResponse(error: e.toString());
    } catch (e) {
      myLogger.logError(e);
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<bool>> signIn(String email, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return const ApiResponse(data: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        myLogger.logMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        myLogger.logMessage('Wrong password provided for that user.');
      }
      return ApiResponse(error: e.toString());
    }
  }
}
