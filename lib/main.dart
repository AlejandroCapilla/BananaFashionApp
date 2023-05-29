import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:banana_fashion/firebase/auth_service.dart';
import 'package:banana_fashion/provider/theme_provider.dart';
import 'package:banana_fashion/routes.dart';
import 'package:banana_fashion/screens/concentric_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

BuildContext? contextForNotification;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message with id ${message.messageId}');
}

void _firebaseMessagingForegroundHandler(RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }

  if (contextForNotification != null) {
    showDialog(
      context: contextForNotification!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Cupon por tiempo limitado!!!',
            style: TextStyle(fontFamily: 'RoundMan'),
          ),
          content: SizedBox(
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Da click en este boton para obtener el cupon!!!',
                  style: TextStyle(fontFamily: 'RoundMan'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OBTENER CUPON',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roundman',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print('token: $fcmToken');
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
