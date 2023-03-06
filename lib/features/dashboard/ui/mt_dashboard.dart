import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:money_tracker/features/stocks/stock_search_delegate.dart';

import '../../../core/api_service/firebase_crud_service/transaction_service/models/transaction_model.dart';
import '../../../core/api_service/firebase_crud_service/transaction_service/transaction_service.dart';
import '../../../core/api_service/firebase_crud_service/utils/categories.dart';
import '../../../core/functions/general_functions.dart';
import '../../../design/widgets/mt_bottom_navbar.dart';
import '../../../design/widgets/mt_drawer.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/ui/login.dart';
import '../bloc/dashboard_bloc.dart';
import 'pages/allowance_page.dart';
import 'pages/stipend_page.dart';
import 'pages/stocks_page.dart';
import 'widgets/transaction_card.dart';

class MtDashboard extends StatefulWidget {
  const MtDashboard({super.key});

  @override
  State<MtDashboard> createState() => _MtDashboardState();
}

class _MtDashboardState extends State<MtDashboard> {
  final List<Widget> _pages = const [
    StocksPage(),
    StipendPage(),
    AllowancePage(),
  ];

  late StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.none) {
        scaffoldMessage(context, 'No internet connection');
      }
    });

    @override
    void dispose() {
      subscription.cancel();
      super.dispose();
    }
  }

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
            drawer: const MtDrawer(),
            appBar: AppBar(
              title: const Text('Money Tracker'),
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // TODO: show modal bottom sheet
                FirebaseAuth auth = FirebaseAuth.instance;
                User? user = auth.currentUser;
                TransactionModel transaction = TransactionModel(
                  amount: 100,
                  title: 'Pastries',
                  category: SpendCategory.entertainment.name,
                  createdAt: DateTime.now(),
                  description: 'Bought some food',
                  id: const Uuid().v1(),
                  spendFrom: SpendFrom.stipend.name,
                );
                TransactionApiService.createDoc(transaction, user!.uid);
              },
              tooltip: 'Add Transaction',
              child: const Icon(Icons.add),
            ),
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
