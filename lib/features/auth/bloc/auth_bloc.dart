import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'package:money_tracker/core/api_service/firebase_crud_service/user_service/models/user_model.dart';

import '../../../core/api_service/firebase_auth_service/firebase_social_login_service.dart';
import '../../../core/api_service/firebase_crud_service/user_service/user_service.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseSocialLoginService googleAuth = FirebaseSocialLoginService();
  AuthBloc() : super(AuthInitialState()) {
    on<AuthRequestEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final isNew = await googleAuth.signInWithGoogle();
        FirebaseAuth auth = FirebaseAuth.instance;
        final user = auth.currentUser;
        final userModel = UserModel(
          id: user!.uid,
          name: user.displayName!,
          email: user.email!,
          photoUrl: user.photoURL,
        );
        if (isNew.getData!) {
          await UserApiService.createDoc(userModel);
        }
      } catch (e) {
        emit(AuthFailureState(e.toString()));
      }
      emit(AuthSuccessState());
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
