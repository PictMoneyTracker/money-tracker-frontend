part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitialState extends DashboardState {}

class DashboardIndexChangedState extends DashboardState {
  final int index;

  DashboardIndexChangedState(this.index);
}

class DashboardLoadingState extends DashboardState {}

class AllowancePageLoadedState extends DashboardState {
  final List<TransactionModel> allowanceTransactions;
  final int allowanceBalance;
  final int allowanceSpent;

  AllowancePageLoadedState(
    this.allowanceTransactions,
    this.allowanceBalance,
    this.allowanceSpent,
  );
}

class StipendPageLoadedState extends DashboardState {
  final List<TransactionModel> stipendTransactions;
  final int stipendBalance;
  final int stipendSpent;

  StipendPageLoadedState(
    this.stipendTransactions,
    this.stipendBalance,
    this.stipendSpent,
  );
}

class StocksPageLoadedState extends DashboardState {
  final List<StockModel> stocks;
  final int stockBalance;

  StocksPageLoadedState(
    this.stocks,
    this.stockBalance,
  );
}

class DashboardErrorState extends DashboardState {
  final String message;

  DashboardErrorState(this.message);
}
