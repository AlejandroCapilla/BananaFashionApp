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
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Banana Fashion',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                accountEmail: Text(
                  user.email!,
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                )),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/popular'),
              title: const Text('API Movies'),
              leading: const Icon(Icons.movie,
                  color: Color.fromARGB(255, 255, 220, 63)),
              trailing: const Icon(Icons.chevron_right,
                  color: Color.fromARGB(255, 255, 220, 63)),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/settings'),
              title: const Text('Settings'),
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
