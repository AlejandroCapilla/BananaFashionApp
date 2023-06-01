import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:banana_fashion/models/github_login_request.dart';
import 'package:banana_fashion/models/github_login_response.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'secret_keys.dart' as SecretKey;
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  bool isVerified = false;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  //Google Sign in
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

  Future logout() async {
    googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future githubLogin() async {
    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        SecretKey.GITHUB_CLIENT_ID +
        "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      print("login: Se lanzo el link");
      // ignore: deprecated_member_use
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      print("login: CANNOT LAUNCH THIS URL!");
    }
  }

  //Para Github
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> loginWithGithub(String code) async {
    //Acces token request
    final response = await http.post(
      Uri.parse("https://github.com/login/oauth/access_token"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(GitHubLoginRequest(
        clientId: SecretKey.GITHUB_CLIENT_ID,
        clientSecret: SecretKey.GITHUB_CLIENT_SECRET,
        code: code,
      )),
    );
    GitHubLoginResponse loginResponse = GitHubLoginResponse.fromJson(
        json.decode(response.body)); //FIREBASE SIGNIN
    final AuthCredential credential =
        GithubAuthProvider.credential(loginResponse.accessToken);

    final User user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
    return user;
  }

  // Autenticacion con correo y contrasena
  Future signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  Future signUp(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  Future resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Se ha enviado un correo para restablecer la contraseña')));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}
