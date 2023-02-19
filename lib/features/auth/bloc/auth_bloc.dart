import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/api_service/firebase_auth_service/firebase_social_login_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseSocialLoginService googleAuth = FirebaseSocialLoginService();
  AuthBloc() : super(AuthInitialState()) {
    on<AuthRequestEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
         await googleAuth.signInWithGoogle();
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthFailureState(e.toString()));
      }
    });
    on<AuthFailureEvent>(
      (event, emit) => emit(
        AuthFailureState(event.message),
      ),
    );

    on<AuthLogoutEvent>((event, emit) async {
      final loggedOut = await googleAuth.signOut();
      if (loggedOut.getData!) {
        emit(AuthInitialState());
      }
    });
  }
}
