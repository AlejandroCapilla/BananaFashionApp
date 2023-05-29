import 'dart:async';

import 'package:banana_fashion/firebase/auth_service.dart';
import 'package:banana_fashion/provider/theme_provider.dart';
import 'package:banana_fashion/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();

    setState(() => canResendEmail = false);
    await Future.delayed(Duration(seconds: 6));
    setState(() => canResendEmail = true);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    String logo = theme.getTheme() == 'oscuro'
        ? 'assets/logo_transparent_white.png'
        : 'assets/logo_transparent.png';

    final spaceHorizontal = SizedBox(
      height: 10,
    );

    return isEmailVerified
        ? DashboardScreen()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          logo,
                          height: 150,
                        ),
                        spaceHorizontal,
                        const Text(
                          'Un correo de verificacion ha sido enviado a tu email.',
                          style:
                              TextStyle(fontFamily: 'Roundman', fontSize: 20),
                        ),
                        spaceHorizontal,
                        ElevatedButton.icon(
                            onPressed: () =>
                                canResendEmail ? sendVerificationEmail() : null,
                            icon: const Icon(Icons.email),
                            label: const Text(
                              'Reenviar correo',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roundman',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            )),
                        spaceHorizontal,
                        TextButton(
                            onPressed: () => FirebaseAuth.instance.signOut(),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roundman',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
