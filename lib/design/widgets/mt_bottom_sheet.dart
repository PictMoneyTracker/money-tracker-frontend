import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../core/api_service/firebase_crud_service/transaction_service/models/transaction_model.dart';
import '../../core/api_service/firebase_crud_service/transaction_service/transaction_service.dart';
import '../../core/api_service/firebase_crud_service/utils/categories.dart';
import '../../features/dashboard/bloc/dashboard_bloc.dart';

class MtBottomSheet extends StatefulWidget {
  final TransactionModel? existingTransaction;

  const MtBottomSheet({
    Key? key,
    required this.spentFrom,
    this.existingTransaction,
  }) : super(key: key);

  final SpendFrom spentFrom;
  @override
  State<MtBottomSheet> createState() => _MtBottomSheetState();
}

class _MtBottomSheetState extends State<MtBottomSheet> {
  static final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final items = SpendCategory.values.toList();
  var dropdownValue = SpendCategory.food;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.existingTransaction != null) {
      titleController.text = widget.existingTransaction!.title;
      descriptionController.text = widget.existingTransaction!.description!;
      amountController.text = widget.existingTransaction!.amount.toString();
      SpendCategory category = SpendCategory.values.firstWhere(
          (element) => element.name == widget.existingTransaction!.category);
      dropdownValue = category;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Container(
          height: 640,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
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
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (int.parse(value) <= 0) {
                      return 'Please enter a valid amount';
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
                        value: dropdownValue,
                        items: items.map((item) {
                          return DropdownMenuItem<SpendCategory>(
                            value: item,
                            child: Text(item.name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // Workaround for the dropdown not updating
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        }),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Todo: Save the data, show alert dialog
                          if (widget.existingTransaction != null) {
                            final txnModel = TransactionModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              amount: int.parse(amountController.text),
                              category: dropdownValue.name,
                              createdAt: widget.existingTransaction!.createdAt,
                              id: widget.existingTransaction!.id,
                              spendFrom: widget.spentFrom.name,
                            );
                            TransactionApiService.updateDoc(
                              txnModel,
                              FirebaseAuth.instance.currentUser!.uid,
                            );
                            if (widget.spentFrom == SpendFrom.stipend) {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(DashboardIndexChangedEvent(1));
                            } else {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(DashboardIndexChangedEvent(2));
                            }
                            Navigator.of(context).pop();
                          } else {
                            final txnModel = TransactionModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              amount: int.parse(amountController.text),
                              category: dropdownValue.name,
                              createdAt: DateTime.now().toString(),
                              id: const Uuid().v4(),
                              spendFrom: widget.spentFrom.name,
                            );
                            TransactionApiService.createDoc(
                              txnModel,
                              FirebaseAuth.instance.currentUser!.uid,
                            );
                            if (widget.spentFrom == SpendFrom.stipend) {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(DashboardIndexChangedEvent(1));
                            } else {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(DashboardIndexChangedEvent(2));
                            }
                            Navigator.of(context).pop();
                          }
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
      },
    );
  }
}
