import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_tracker/core/logger/my_logger.dart';

import '../../../core/api_service/firebase_auth_service/firebase_social_login_service.dart';
import '../../../core/logger/logger_modules/devtools_logger_module.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            MyLogger logger = MyLogger.createInstance([DevToolsLoggerModule()]);
            FirebaseSocialLoginService signInWithGoogle =
                FirebaseSocialLoginService();
            final didChange = await signInWithGoogle.signInWithGoogle();
            log("Auth Success: ${didChange.getData}");
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
