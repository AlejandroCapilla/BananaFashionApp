import 'package:banana_fashion/widgets/card_producto_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Tu carrito"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('carrito')
            .doc(user.uid)
            .collection('producto')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return CardProductoId(
                  id: snapshot.data!.docs[index]['idProducto'],
                );
              },
            );
          } else {
            return Text("no data");
          }
        },
      ),
    );
  }
}
