import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/core/api_service/firebase_crud_service/firebase_crud_service.dart';
import 'features/dashboard/ui/mt_dashboard.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // test command
  // FirebaseCRUDApiService.createDoc();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MtDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
