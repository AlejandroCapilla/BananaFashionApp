import 'package:banana_fashion/screens/carrito_screen.dart';
import 'package:banana_fashion/screens/forgot_password_screen.dart';
import 'package:banana_fashion/screens/home_page.dart';
import 'package:banana_fashion/screens/profile_screen.dart';
import 'package:banana_fashion/screens/register_screen.dart';
import 'package:banana_fashion/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:banana_fashion/screens/login_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginScreen(),
    '/home': (BuildContext context) => const HomePage(),
    '/settings': (BuildContext context) => const SettingsScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/forgot_password': (BuildContext context) => const ForgotPasswordScreen(),
    '/carrito': (BuildContext context) => const CarritoScreen(),
    '/profile': (BuildContext context) => const ProfileScreen()
  };
}
