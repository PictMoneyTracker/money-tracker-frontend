import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../design/widgets/mt_bottom_navbar.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/ui/login.dart';
import 'widgets/balance_card.dart';
import 'widgets/transaction_card.dart';

class MtDashboard extends StatelessWidget {
  const MtDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitialState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Money Tracker'),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            tooltip: 'Show Menu',
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
              },
              icon: const Icon(Icons.settings),
              tooltip: 'Show Settings',
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BalanceCard(),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: const Text(
                'Lorem Ipsum',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: ListViewBuilder(),
            ),
          ],
        ),
        bottomNavigationBar: const MtBottomNavbar(),
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                // offset: Offset(0, 3),
              ),
            ],
          ),
          child: const TransactionCard(),
        );
      },
    );
  }
}
