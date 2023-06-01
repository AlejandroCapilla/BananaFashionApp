import 'package:cloud_firestore/cloud_firestore.dart';

class ProductosModel {
  String? id;
  String? nombre;
  num? precio;
  String? descripcion;
  String? marca;
  List<String>? imagenes;

  ProductosModel(
      {this.id,
      this.nombre,
      this.precio,
      this.descripcion,
      this.marca,
      this.imagenes});

  factory ProductosModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return ProductosModel(
        id: map['id'],
        nombre: map['nombre'],
        precio: map['precio'],
        descripcion: map['descripcion'],
        marca: map['marca'],
        imagenes: map['imagenes'].cast<String>());
  }
}
