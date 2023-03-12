import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api_service/firebase_crud_service/transaction_service/models/transaction_model.dart';
import '../../../core/api_service/firebase_crud_service/transaction_service/transaction_service.dart';
import '../../../core/api_service/firebase_crud_service/utils/categories.dart';
import '../../../core/functions/general_functions.dart';
import '../../../design/widgets/mt_alert_box.dart';
import '../../../design/widgets/mt_bottom_navbar.dart';
import '../../../design/widgets/mt_bottom_sheet.dart';
import '../../../design/widgets/mt_drawer.dart';
import '../../../design/widgets/mt_loader.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/ui/login.dart';
import '../../stocks/stock_search_delegate.dart';
import '../bloc/dashboard_bloc.dart';
import 'pages/allowance_page.dart';
import 'pages/stipend_page.dart';
import 'pages/stocks_page.dart';
import 'widgets/stock_card.dart';
import 'widgets/transaction_card.dart';

class MtDashboard extends StatefulWidget {
  const MtDashboard({super.key});

  @override
  State<MtDashboard> createState() => _MtDashboardState();
}

class _MtDashboardState extends State<MtDashboard> {
  late StreamSubscription subscription;

  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(
      DashboardInitialEvent(),
    );
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result != ConnectivityResult.mobile &&
          result != ConnectivityResult.wifi) {
        scaffoldMessage(context, 'No internet connection');
      }
    });
    BlocProvider.of<DashboardBloc>(context).add(DashboardIndexChangedEvent(0));
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
          User user = FirebaseAuth.instance.currentUser!;

          return Scaffold(
            drawer: MtDrawer(
              user: user,
            ),
            appBar: AppBar(
              title: const Text('Money Tracker'),
            ),
            body: IndexedStack(
              index: context.select((DashboardBloc bloc) => bloc.currentIndex),
              children: [
                state is StocksPageLoadedState
                    ? StocksPage(stocks: state.stocks)
                    : const Center(
                        child: MtLoader(),
                      ),
                state is StipendPageLoadedState
                    ? const StipendPage()
                    : const Center(
                        child: MtLoader(),
                      ),
                state is AllowancePageLoadedState
                    ? const AllowancePage()
                    : const Center(
                        child: MtLoader(),
                      ),
              ],
            ),
            bottomNavigationBar: const MtBottomNavbar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (state is StocksPageLoadedState) {
                  showSearch(
                    context: context,
                    delegate: StockSearchDelegate(),
                  );
                } else if (state is DashboardLoadingState) {
                  scaffoldMessage(context, 'Loading...');
                } else if (state is DashboardErrorState) {
                  scaffoldMessage(context, state.message);
                } else if (state is StipendPageLoadedState) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return const MtBottomSheet(
                        spentFrom: SpendFrom.stipend,
                      );
                    },
                  );
                } else if (state is AllowancePageLoadedState) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return const MtBottomSheet(
                        spentFrom: SpendFrom.allowance,
                      );
                    },
                  );
                }
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
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoadingState) {
          return const Center(
            child: MtLoader(),
          );
        } else if (state is DashboardErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is StocksPageLoadedState) {
          return ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                child: StockCard(
                  stockName: state.stocks[index].name,
                  stockSymbol: state.stocks[index].symbol,
                ),
              );
            },
          );
        } else if (state is StipendPageLoadedState) {
          return ListView.builder(
            itemCount: state.stipendTransactions.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MtAlertBox(
                        content:
                            "Are you sure you want to delete this transaction?",
                        title: "Delete Transaction",
                        onPressed: () {
                          TransactionApiService.deleteDoc(
                            FirebaseAuth.instance.currentUser!.uid,
                            state.stipendTransactions[index].id,
                          );
                          BlocProvider.of<DashboardBloc>(context).add(
                            DashboardIndexChangedEvent(1),
                          );
                        },
                      );
                    },
                  );
                },
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      TransactionModel transaction =
                          state.stipendTransactions[index];
                      return MtBottomSheet(
                        spentFrom: SpendFrom.stipend,
                        existingTransaction: transaction,
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
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
                  child: TransactionCard(
                    transaction: state.stipendTransactions[index],
                  ),
                ),
              );
            },
          );
        } else if (state is AllowancePageLoadedState) {
          return ListView.builder(
            itemCount: state.allowanceTransactions.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MtAlertBox(
                        content:
                            "Are you sure you want to delete this transaction?",
                        title: "Delete Transaction",
                        onPressed: () {
                          TransactionApiService.deleteDoc(
                            FirebaseAuth.instance.currentUser!.uid,
                            state.allowanceTransactions[index].id,
                          );
                          BlocProvider.of<DashboardBloc>(context).add(
                            DashboardIndexChangedEvent(2),
                          );
                        },
                      );
                    },
                  );
                },
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      TransactionModel transaction =
                          state.allowanceTransactions[index];
                      return MtBottomSheet(
                        spentFrom: SpendFrom.allowance,
                        existingTransaction: transaction,
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
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
                  child: TransactionCard(
                    transaction: state.allowanceTransactions[index],
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text('No data'),
        );
      },
    );
  }
}
