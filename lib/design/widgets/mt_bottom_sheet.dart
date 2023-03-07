import 'package:flutter/material.dart';
import 'package:money_tracker/core/api_service/firebase_crud_service/utils/categories.dart';

class MtBottomSheet extends StatelessWidget {
  MtBottomSheet({super.key});
  static final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'Item 1';
    final items = SpendCategory.values.toList();
    return Container(
      height: 640,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20),
      child: Form(
        key: formKey,
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Title",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
            TextFormField(
              maxLength: 50,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter your Title',
                border: OutlineInputBorder(),
                counter: Offstage(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
            const Text(
              "Description",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
            TextFormField(
              maxLength: 150,
              minLines: 1,
              maxLines: 10,
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter your Description',
                border: OutlineInputBorder(),
                counter: Offstage(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
            const Text(
              "Amount",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
            TextFormField(
              validator: (value) {
                String pattern = r'^\d+(?:\.\d+)?$';
                RegExp regex = RegExp(pattern);
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (!regex.hasMatch(value)) {
                  return 'Enter Valid Number';
                } else {
                  return null;
                }
              },
              maxLength: 10,
              controller: amountController,
              decoration: const InputDecoration(
                hintText: 'Enter your amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee),
                counter: Offstage(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
            const Text(
              "Category",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<SpendCategory>(
                    value: SpendCategory.food,
                    items: items.map((item) {
                      return DropdownMenuItem<SpendCategory>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      // setState(() {
                      //   dropdownvalue = newValue!;
                      // });
                    }),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Todo: Save the data, show alert dialog
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
    ;
  }
}
