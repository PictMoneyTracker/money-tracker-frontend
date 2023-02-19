import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/core/functions/general_functions.dart';
import 'package:money_tracker/features/dashboard/ui/mt_dashboard.dart';

import '../bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              navigate(context, const MtDashboard());
            }
            if (state is AuthFailureState) {
              scaffoldMessage(context, "Error: ${state.message}");
            }
          },
          builder: (context, state) {
            if (state is AuthInitialState) {
              // TODO: Add UI here 
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(AuthRequestEvent());
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
                    },
                    child: const Text("Logout"),
                  ),
                ],
              );
            }
            if (state is AuthFailureState) {
              return Text(state.message); // TODO: Beautify this
            }
            if (state is AuthLoadingState) {
              return const CircularProgressIndicator(); // TODO: extract to widget
            } else {
              return const Text('Unknown state');
            }
          },
        ),
      ),
    );
  }
}
