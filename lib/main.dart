import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/ui/login.dart';
import 'core/logger/logger_modules/devtools_logger_module.dart';
import 'core/logger/my_logger.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/dashboard/bloc/dashboard_bloc.dart';
import 'features/dashboard/ui/mt_dashboard.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MyLogger.createInstance([DevToolsLoggerModule()]);
  // test command
  // FirebaseCRUDApiService.createDoc();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Money Tracker';

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        home: user != null ? const MtDashboard() : const AuthPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
