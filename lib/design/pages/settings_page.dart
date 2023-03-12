import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/api_service/firebase_crud_service/user_service/models/user_model.dart';
import '../../core/api_service/firebase_crud_service/user_service/user_service.dart';
import '../widgets/mt_alert_box.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;
  static final formKey1 = GlobalKey<FormState>();

  final TextEditingController stipendController = TextEditingController();
  final TextEditingController allowanceController = TextEditingController();
  final TextEditingController stocksController = TextEditingController();

  @override
  void initState() {
    UserApiService.readDoc(user!.uid).then((value) {
      if (value.hasException) {
        log(value.getException!);
      }
      final currentUser = value.getData;
      stipendController.text = currentUser!.stipendTotal.toString();
      allowanceController.text = currentUser.allowanceTotal.toString();
      stocksController.text = currentUser.stockTotal.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Stipend",
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(10, 173, 18, 0.698)),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                controller: stipendController,
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: 'Enter your stipend',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.currency_rupee),
                  counter: Offstage(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text(
                "Allowance",
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(10, 173, 18, 0.698)),
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  controller: allowanceController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    hintText: 'Enter your allowance',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.currency_rupee),
                    counter: Offstage(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              const Text(
                "Stocks",
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(10, 173, 18, 0.698)),
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  controller: stocksController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    hintText: 'Enter your stocks',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.currency_rupee),
                    counter: Offstage(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  keyboardType: TextInputType.number),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (formKey1.currentState!.validate()) {
                      // Todo: Save the data, show alert dialog
                      UserModel updatedUser = UserModel(
                        id: user!.uid,
                        email: user!.email!,
                        name: user!.displayName!,
                        photoUrl: user!.photoURL,
                        stipendTotal: int.parse(stipendController.text),
                        allowanceTotal: int.parse(allowanceController.text),
                        stockTotal: int.parse(stocksController.text),
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MtAlertBox(
                            title: 'Alert',
                            content: "Do you want to save?",
                            onPressed: () {
                              UserApiService.updateDoc(updatedUser);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
