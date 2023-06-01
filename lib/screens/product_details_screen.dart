import 'package:banana_fashion/models/productos_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexi_productimage_slider/flexi_productimage_slider.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  ProductosModel productosModel;
  ProductDetails({super.key, required this.productosModel});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Detalles del producto"),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              flexi_productimage_slider(
                  arrayImages: widget.productosModel.imagenes!,
                  aspectRatio: 3 / 4,
                  boxFit: BoxFit.cover,
                  thumbnailPosition: ThumbnailPosition.BOTTOM,
                  thumbnailShape: ThumbnailShape.Square,
                  sliderStyle: SliderStyle.Style2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.productosModel.nombre!,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.productosModel.descripcion!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.productosModel.precio!} MXN",
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Agregar a carrito"),
                  onPressed: () async {
                    final docProduct = FirebaseFirestore.instance
                        .collection('carrito')
                        .doc(user.uid)
                        .collection('producto')
                        .where("idProducto",
                            isEqualTo: widget.productosModel.id);
                    final snapProduct = await docProduct.get();

                    if (snapProduct.size == 0) {
                      CollectionReference collectionRef = FirebaseFirestore
                          .instance
                          .collection('carrito')
                          .doc(user.uid)
                          .collection('producto');
                      await collectionRef
                          .add({'idProducto': widget.productosModel.id});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        elevation: 6.0,
                        behavior: SnackBarBehavior.floating,
                        content:
                            const Text("Ya Tienes este producto en tu carrito"),
                        duration: const Duration(milliseconds: 500),
                      ));
                    }
                  },
                ),
              )
            ]),
      ),
    );
  }
}
