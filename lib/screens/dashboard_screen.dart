import 'package:banana_fashion/main.dart';
import 'package:banana_fashion/models/productos_model.dart';
import 'package:banana_fashion/widgets/card_producto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.instance.getInitialMessage();
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  bool isDarkThemeEnable = true;

  @override
  Widget build(BuildContext context) {
    contextForNotification = context;
    final user = FirebaseAuth.instance.currentUser!;
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('productos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return CardProducto(
                  productosModel:
                      ProductosModel.fromFirestore(snapshot.data!.docs[index]),
                );
              },
            );
          } else {
            return Text("no data");
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : const NetworkImage(
                          'https://definicion.de/wp-content/uploads/2019/07/perfil-de-usuario.png'),
                ),
                accountName: Text(
                  user.displayName != null ? user.displayName! : '',
                  style: const TextStyle(
                    fontFamily: 'Roundman',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                accountEmail: Text(
                  user.email != null ? user.email! : '',
                  style: const TextStyle(
                    fontFamily: 'Roundman',
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                )),
            ListTile(
              onTap: () {},
              title: const Text('Mi perfil',
                  style: TextStyle(fontFamily: 'Roundman')),
              leading: const Icon(Icons.person,
                  color: Color.fromARGB(255, 255, 220, 63)),
              trailing: const Icon(Icons.chevron_right,
                  color: Color.fromARGB(255, 255, 220, 63)),
            ),
            ListTile(
              onTap: () => {Navigator.pushNamed(context, '/carrito')},
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
