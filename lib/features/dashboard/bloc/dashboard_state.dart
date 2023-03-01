part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitialState extends DashboardState {}

class DashboardIndexChangedState extends DashboardState {
  final int index;

  DashboardIndexChangedState(this.index);
}

class DashboardLoadingState extends DashboardState {}

class AllowancePageLoadedState extends DashboardState {}

class StipendPageLoadedState extends DashboardState {}

class StocksPageLoadedState extends DashboardState {}

class DashboardErrorState extends DashboardState {
  final String message;

  DashboardErrorState(this.message);
}
