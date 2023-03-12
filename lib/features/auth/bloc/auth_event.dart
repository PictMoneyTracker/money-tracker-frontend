part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthRequestEvent extends AuthEvent {}

class AuthFailureEvent extends AuthEvent {
  final String message;

  AuthFailureEvent(this.message);
}

class AuthLogoutEvent extends AuthEvent {}
