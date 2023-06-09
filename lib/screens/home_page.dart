import 'package:banana_fashion/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:banana_fashion/screens/dashboard_screen.dart';
import 'package:banana_fashion/screens/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Algo salio mal :('));
              } else if (snapshot.hasData) {
                return FirebaseAuth
                        .instance.currentUser!.providerData[0].providerId
                        .toLowerCase()
                        .contains('password')
                    ? VerifyEmailScreen()
                    : DashboardScreen();
              } else {
                return LoginScreen();
              }
            }),
      );
}
