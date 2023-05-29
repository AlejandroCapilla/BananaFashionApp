import 'dart:async';
import 'package:banana_fashion/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:banana_fashion/firebase/auth_service.dart';
import 'package:banana_fashion/widgets/loading_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:uni_links/uni_links.dart';
import '../responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StreamSubscription? _subs;
  final AuthService authService = AuthService();
  bool isLoading = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = linkStream.listen((link) {
      _checkDeepLink(link!.toString());
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      print("login: code =$code");
      authService.loginWithGithub(code).then((firebaseUser) {
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: ${firebaseUser.displayName}");
      }).catchError((e) {
        print("login: ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs!.cancel();
      _subs = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    String background = theme.getTheme() == 'oscuro'
        ? 'assets/dark_theme_background.png'
        : 'assets/light_theme_background.png';
    String logo = theme.getTheme() == 'oscuro'
        ? 'assets/logo_transparent_white.png'
        : 'assets/logo_transparent.png';

    final txtEmail = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
          label: Text('Email User'), enabledBorder: OutlineInputBorder()),
    );

    final txtPass = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Password User'), enabledBorder: OutlineInputBorder()),
    );

    final spaceHorizontal = SizedBox(
      height: 10,
    );

    final spaceVertical = SizedBox(
      width: 100,
    );

    final btnLogin = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          AuthService().signIn(emailController.text, passwordController.text);
        });

    final btnGoogle = SocialLoginButton(
        buttonType: SocialLoginButtonType.google,
        onPressed: () {
          AuthService().googleLogin();
        });

    final btnFacebook = SocialLoginButton(
        buttonType: SocialLoginButtonType.github,
        onPressed: () {
          AuthService().githubLogin();
        });

    final txtRegister = Padding(
      padding: const EdgeInsets.all(0),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: const Text('Registrarse',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 18,
                fontFamily: 'Roundman')),
      ),
    );

    final txtForgotPassword = Padding(
      padding: const EdgeInsets.all(0),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/forgot_password');
        },
        child: const Text('Olvide mi contraseña',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
                fontFamily: 'Roundman')),
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Responsive(
            mobile: MobileWelcomeScreen(
                txtEmail: txtEmail,
                spaceHorizontal: spaceHorizontal,
                txtPass: txtPass,
                btnLogin: btnLogin,
                btnGoogle: btnGoogle,
                btnFacebook: btnFacebook,
                txtRegister: txtRegister,
                txtForgotPassword: txtForgotPassword,
                isLoading: isLoading),
            desktop: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(background),
                      fit: BoxFit.cover,
                      opacity: 0.5)),
              child: Row(
                children: [
                  spaceVertical,
                  Positioned(
                    top: 40,
                    left: 40,
                    child: Image.asset(
                      logo,
                      height: 400,
                    ),
                  ),
                  spaceVertical,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        txtEmail,
                        spaceHorizontal,
                        txtPass,
                        spaceHorizontal,
                        btnLogin,
                        spaceHorizontal,
                        const Text('or'),
                        spaceHorizontal,
                        btnGoogle,
                        spaceHorizontal,
                        btnFacebook,
                        spaceHorizontal,
                        txtRegister,
                        txtForgotPassword
                      ],
                    ),
                  ),
                  spaceVertical
                ],
              ),
            )));
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    super.key,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.txtRegister,
    required this.txtForgotPassword,
    required this.isLoading,
  });

  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final Padding txtRegister;
  final Padding txtForgotPassword;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    String background = theme.getTheme() == 'oscuro'
        ? 'assets/dark_theme_background.png'
        : 'assets/light_theme_background.png';
    String logo = theme.getTheme() == 'oscuro'
        ? 'assets/logo_transparent_white.png'
        : 'assets/logo_transparent.png';

    return Stack(
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(background),
                  fit: BoxFit.cover,
                  opacity: 0.9)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    txtEmail,
                    spaceHorizontal,
                    txtPass,
                    spaceHorizontal,
                    btnLogin,
                    spaceHorizontal,
                    const Text('or'),
                    spaceHorizontal,
                    btnGoogle,
                    spaceHorizontal,
                    btnFacebook,
                    spaceHorizontal,
                    txtRegister,
                    txtForgotPassword
                  ],
                ),
                Positioned(
                  top: 40,
                  child: Image.asset(
                    logo,
                    height: 240,
                  ),
                )
              ],
            ),
          ),
        ),
        isLoading ? const LoadingModalWidget() : Container(),
      ],
    );
  }
}
