import 'dart:io';
import 'package:banana_fashion/firebase/auth_service.dart';
import 'package:banana_fashion/provider/theme_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isEmailVerified = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool checkTextFields() {
    if (EmailValidator.validate(emailController.text) &&
        passwordController.text.trim() != '' &&
        passwordController.text.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    String logo = theme.getTheme() == 'oscuro'
        ? 'assets/logo_transparent_white.png'
        : 'assets/logo_transparent.png';

    final txtCorreo = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
          label: Text('Email'), enabledBorder: OutlineInputBorder()),
    );

    final txtPass = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Password User'), enabledBorder: OutlineInputBorder()),
    );

    final txtRegister = Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            if (checkTextFields()) {
              AuthService().signUp(
                  emailController.text, passwordController.text, context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ingrese valores validos :)')));
            }
          },
          child: const Text(
            '   Registrarme   ',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roundman',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ));

    const spaceHorizontal = SizedBox(
      height: 10,
    );

    return Scaffold(
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
                    'Registrarse',
                    style: TextStyle(fontFamily: 'Roundman', fontSize: 26),
                  ),
                  spaceHorizontal,
                  spaceHorizontal,
                  spaceHorizontal,
                  txtCorreo,
                  spaceHorizontal,
                  txtPass,
                  txtRegister
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
