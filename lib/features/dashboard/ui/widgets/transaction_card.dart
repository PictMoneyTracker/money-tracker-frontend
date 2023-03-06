import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
      // dateFormat = 'MM/dd/yy';
      final DateTime docDateTime = DateTime.parse(givenDateTime);
      return DateFormat(dateFormat).format(docDateTime);
    }

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Title',
              style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 250.0,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed eros turpis.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.currency_rupee,
                color: Colors.grey,
                size: 20.0,
              ),
              Text(
                "100",
                style: TextStyle(color: Colors.green, fontSize: 15.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Category',
                  style: TextStyle(fontSize: 15.0), textAlign: TextAlign.left),
              Text(
                getCustomFormattedDateTime(
                    '2021-02-15T18:42:49.608466Z', 'dd/MM/yy'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
