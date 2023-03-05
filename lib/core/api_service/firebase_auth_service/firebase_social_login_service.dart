import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../api_layer/api_response.dart';
import '../../logger/my_logger.dart';

class FirebaseSocialLoginService {
  final MyLogger myLogger = MyLogger.getInstance;
  Future<ApiResponse<bool>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final isNew = userCredential.additionalUserInfo?.isNewUser;
      return ApiResponse(data: isNew);
    } catch (e) {
      myLogger.logError(e);
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<bool>> signOut() async {
    await FirebaseAuth.instance.signOut();
    try {
      return const ApiResponse(data: true);
    } catch (e) {
      myLogger.logError(e);
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<bool>> signOut() async {
    await FirebaseAuth.instance.signOut();
    try {
      return const ApiResponse(data: true);
    } catch (e) {
      myLogger.logError(e);
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<bool>> signInWithApple() async {
    try {
      String generateNonce([int length = 32]) {
        const charset =
            '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
        final random = Random.secure();
        return List.generate(
            length, (_) => charset[random.nextInt(charset.length)]).join();
      }

      String sha256ofString(String input) {
        final bytes = utf8.encode(input);
        final digest = sha256.convert(bytes);
        return digest.toString();
      }

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return const ApiResponse(data: true);
    } catch (err) {
      myLogger.logError(e);
      return ApiResponse(error: e.toString());
    }
  }
}
