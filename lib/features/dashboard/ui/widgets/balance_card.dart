import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      margin: const EdgeInsets.all(8),
      height: 170,
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              margin: const EdgeInsets.all(8),
              height: 150,
              alignment: Alignment.center,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.currency_rupee,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      Text(
                        "100",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_upward_rounded,
                        color: Color.fromARGB(255, 0, 158, 5),
                        size: 30,
                      ),
                      const Text(
                        "Income",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      const Icon(Icons.arrow_downward_rounded,
                          color: Colors.red, size: 30),
                      const Text(
                        "Expenses",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.currency_rupee,
                          color: Colors.white, size: 20),
                      const Text(
                        "10000",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      const Icon(Icons.currency_rupee,
                          color: Colors.white, size: 20),
                      const Text(
                        "100",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
