import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Stipend",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const TextField(
              maxLength: 10,
              decoration: InputDecoration(
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
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const TextField(
                maxLength: 10,
                decoration: InputDecoration(
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
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const TextField(
                maxLength: 10,
                decoration: InputDecoration(
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
                ),
                onPressed: () {},
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
