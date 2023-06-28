import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import 'landing_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: dotenv.env["googleProviderClientId"]!)
            ],
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text(
                        'Welcome to Parky, please sign in to register your vehicle!')
                    : const Text(
                        'Welcome to Parky, please sign up to register your vehicle!'),
              );
            },
          );
        }
        return const LandingPage();
      },
    );
  }
}
