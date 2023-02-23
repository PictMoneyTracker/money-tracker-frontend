part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);
}

class AuthLoadingState extends AuthState {}
