import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:banana_fashion/firebase/auth_service.dart';
import 'package:banana_fashion/provider/theme_provider.dart';
import 'package:banana_fashion/routes.dart';
import 'package:banana_fashion/screens/concentric_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String theme;
  if (prefs.getString('theme') != null) {
    theme = prefs.getString('theme')!;
  } else {
    theme = 'oscuro';
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => ThemeProvider(context, theme)),
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService())
    ],
    child: PMSNApp(),
  ));
}

class PMSNApp extends StatelessWidget {
  PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        theme: theme.getThemeData(),
        routes: getApplicationRoutes(),
        home: ConcentricTrasition());
  }
}
