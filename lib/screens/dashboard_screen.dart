import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkThemeEnable = true;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Banana Fashion',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 220, 63),
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roundman',
            letterSpacing: 1,
          ),
        ),
        backgroundColor: theme.getTheme() == 'oscuro'
            ? const Color.fromARGB(255, 70, 70, 70)
            : Colors.white,
        foregroundColor: const Color.fromARGB(255, 255, 220, 63),
      ),
      // body: const ListPostScreen() == true
      //     ? const ListPostScreen()
      //     : ListPostScreen(),
      body: Container(),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                accountName: Text(
                  user.displayName!,
                  style: const TextStyle(
                    fontFamily: 'Roundman',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                accountEmail: Text(
                  user.email!,
                  style: const TextStyle(
                    fontFamily: 'Roundman',
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                )),
            ListTile(
              onTap: () => {},
              title: const Text('Mi perfil',
                  style: TextStyle(fontFamily: 'Roundman')),
              leading: const Icon(Icons.person,
                  color: Color.fromARGB(255, 255, 220, 63)),
              trailing: const Icon(Icons.chevron_right,
                  color: Color.fromARGB(255, 255, 220, 63)),
            ),
            ListTile(
              onTap: () => {},
              title: const Text('Carrito de compras',
                  style: TextStyle(fontFamily: 'Roundman')),
              leading: const Icon(Icons.shopping_cart,
                  color: Color.fromARGB(255, 255, 220, 63)),
              trailing: const Icon(Icons.chevron_right,
                  color: Color.fromARGB(255, 255, 220, 63)),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/settings'),
              title: const Text('Settings',
                  style: TextStyle(fontFamily: 'Roundman')),
              leading: const Icon(Icons.settings,
                  color: Color.fromARGB(255, 255, 220, 63)),
              trailing: const Icon(Icons.chevron_right,
                  color: Color.fromARGB(255, 255, 220, 63)),
            ),
          ],
        ),
      ),
    );
  }
}
