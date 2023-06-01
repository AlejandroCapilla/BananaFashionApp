import 'package:banana_fashion/firebase/firebase_producto.dart';
import 'package:banana_fashion/models/productos_model.dart';
import 'package:banana_fashion/screens/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardProductoId extends StatelessWidget {
  String id;
  CardProductoId({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FireBaseProducto.getProduct(id),
        builder:
            (BuildContext context, AsyncSnapshot<ProductosModel?> snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      productosModel: snapshot.data!,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!.imagenes![0],
                        imageBuilder: (context, imageProvider) => Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 15, 15, 15)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                        ),
                        placeholder: (context, url) => SizedBox(
                          height: 100,
                          width: 150,
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.25),
                              highlightColor: Colors.white.withOpacity(0.6),
                              child: Container(
                                width: 250.0,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey),
                              )),
                        ),
                        errorWidget: (context, url, error) => SizedBox(
                          height: 100,
                          width: 150,
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.25),
                              highlightColor: Colors.white.withOpacity(0.6),
                              child: Container(
                                width: 250.0,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey),
                              )),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: Theme.of(context).colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 15, 15, 15)
                                  .withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                child: Text(
                                  snapshot.data!.nombre!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
                              child: Text(
                                "${snapshot.data!.precio!} MXN",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(snapshot.data!.marca!),
                            )
                          ],
                        ),
                      ))
                ]),
              ),
            );
          } else {
            return SizedBox(
              height: 100,
              width: 300,
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.25),
                  highlightColor: Colors.white.withOpacity(0.6),
                  child: Container(
                    width: 250.0,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey),
                  )),
            );
          }
        });
  }
}
