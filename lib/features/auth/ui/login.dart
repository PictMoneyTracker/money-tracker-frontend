import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/core/functions/general_functions.dart';
import 'package:money_tracker/features/dashboard/ui/mt_dashboard.dart';

import '../../../design/widgets/mt_loader.dart';
import '../bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
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
            return ListView(
              padding: const EdgeInsets.all(15),
              children: <Widget>[
                Image.asset(
                  'assets/images/clipart_money.png',
                  height: 400,
                  width: 300,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Money Tracker',
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 150),
                      textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  displayFullTextOnTap: true,
                  stopPauseOnTap: false,
                ),
                const SizedBox(height: 150),
                FloatingActionButton.extended(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthRequestEvent());
                  },
                  icon: Image.asset(
                    'assets/images/google_logo.png',
                    height: 32,
                    width: 32,
                  ),
                  label: const Text('Sign in with Google'),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ],
            );
          }
          if (state is AuthFailureState) {
            return Center(
              child: Text(state.message),
            ); // TODO: Beautify this
          }
          if (state is AuthLoadingState) {
            return const Center(
              child: MtLoader(),
            );
          } else {
            return const Text('Unknown state');
          }
        },
      ),
    );
  }
}
