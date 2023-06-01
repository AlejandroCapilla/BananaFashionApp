import 'package:banana_fashion/firebase/auth_service.dart';
import 'package:banana_fashion/provider/theme_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    String logo = theme.getTheme() == 'oscuro'
        ? 'assets/logo_transparent_white.png'
        : 'assets/logo_transparent.png';

    final txtEmail = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
          label: Text('Email User'), enabledBorder: OutlineInputBorder()),
    );

    final btnEnviarCodigo = Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            if (EmailValidator.validate(emailController.text)) {
              AuthService().resetPassword(emailController.text, context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ingrese un correo valido :)')));
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                255,
                255,
                220,
                63)), // Reemplaza Colors.blue con el color deseado
          ),
          child: const Text(
            'Reestablecer contraseña',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roundman',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ));

    final spaceHorizontal = SizedBox(
      height: 10,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                    'Recive un email para restablecer tu contraseña',
                    style: TextStyle(fontFamily: 'Roundman', fontSize: 20),
                  ),
                  spaceHorizontal,
                  spaceHorizontal,
                  spaceHorizontal,
                  txtEmail,
                  spaceHorizontal,
                  btnEnviarCodigo
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
