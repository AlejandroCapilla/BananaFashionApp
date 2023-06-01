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

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;

  late final AnimationController _controllerText = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..forward();
  late final Animation<double> _animationText =
      Tween(begin: 0.0, end: 1.0).animate(_controllerText);

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerText.dispose();
    super.dispose();
  }

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
                child: FadeTransition(
                  opacity: _animationText,
                  child: Text(
                    widget.productosModel.nombre!,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roundman'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeTransition(
                  opacity: _animationText,
                  child: Text(
                    widget.productosModel.descripcion!,
                    style:
                        const TextStyle(fontSize: 16, fontFamily: 'Roundman'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeTransition(
                  opacity: _animationText,
                  child: Text(
                    "${widget.productosModel.precio!} MXN",
                    style:
                        const TextStyle(fontSize: 22, fontFamily: 'Roundman'),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _animationText,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      "Agregar a carrito",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Roundman',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
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
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          elevation: 6.0,
                          behavior: SnackBarBehavior.floating,
                          content: const Text(
                              "Ya Tienes este producto en tu carrito"),
                          duration: const Duration(milliseconds: 500),
                        ));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 255, 220,
                              63)), // Reemplaza Colors.blue con el color deseado
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
