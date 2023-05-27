import 'package:flutter/material.dart';
import 'package:banana_fashion/firebase/auth_service.dart';
import 'package:banana_fashion/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings/styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> items = ['claro', 'oscuro'];
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    final spaceHorizontal = SizedBox(
      height: 10,
    );

    changeTheme(String theme) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('theme', theme);
    }

    final btnLogout = ElevatedButton(
      onPressed: () {
        AuthService().logout();
        Navigator.pop(context);
      },
      child: const Text(
        '         Logout         ',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Roundman',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: 1,
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              spaceHorizontal,
              Row(
                children: [
                  const Text(
                    'Tema:    ',
                    style: TextStyle(fontFamily: 'Roundman', fontSize: 16),
                  ),
                  DropdownButton<String>(
                    value: theme.getTheme(),
                    onChanged: (value) {
                      if (value == 'claro') {
                        changeTheme('claro');
                        theme.setThemeData(StylesApp.lightTheme(context));
                      } else if (value == 'oscuro') {
                        changeTheme('oscuro');
                        theme.setThemeData(StylesApp.darkTheme(context));
                      }
                      setState(() {
                        theme.setTheme(value!);
                      });
                    },
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontFamily: 'Roundman',
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: btnLogout,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
