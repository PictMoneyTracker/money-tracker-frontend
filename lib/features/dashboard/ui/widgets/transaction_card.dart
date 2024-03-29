import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api_service/firebase_crud_service/transaction_service/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    String getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
      final DateTime docDateTime = DateTime.parse(givenDateTime);
      return DateFormat(dateFormat).format(docDateTime);
    }

    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction.title,
            style: const TextStyle(
                fontSize: 20.0,
                color: Colors.green,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 250.0,
                child: Text(
                  transaction.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Icon(
                Icons.currency_rupee,
                color: Colors.green,
                size: 20.0,
              ),
              Text(
                transaction.amount.toString(),
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction.category,
                style: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
              Text(
                getCustomFormattedDateTime(
                  transaction.createdAt!,
                  'dd/MM/yy',
                ),
                style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
