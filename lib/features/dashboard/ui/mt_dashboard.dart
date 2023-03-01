import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design/widgets/mt_bottom_navbar.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/ui/login.dart';
import '../bloc/dashboard_bloc.dart';
import 'pages/allowance_page.dart';
import 'pages/stipend_page.dart';
import 'pages/stocks_page.dart';
import 'widgets/balance_card.dart';
import 'widgets/transaction_card.dart';

class MtDashboard extends StatelessWidget {
  const MtDashboard({super.key});

  final List<Widget> _pages = const [
    StocksPage(),
    StipendPage(),
    AllowancePage(),
  ];

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
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Scaffold(
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
            body: IndexedStack(
              index: context.select((DashboardBloc bloc) => bloc.currentIndex),
              children: _pages,
            ),
            bottomNavigationBar: const MtBottomNavbar(),
          );
        },
      ),
    );
  }
}

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({Key? key}) : super(key: key);

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
