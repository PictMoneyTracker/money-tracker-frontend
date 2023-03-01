part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {}

class DashboardIndexChangedEvent extends DashboardEvent {
  final int index;

  DashboardIndexChangedEvent(this.index);
}

