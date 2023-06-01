import 'package:banana_fashion/models/productos_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseProducto {
  static Future<ProductosModel?> getProduct(String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('productos').doc(id).get();
    if (snapshot.exists) {
      return ProductosModel.fromFirestore(snapshot);
    } else {
      return null;
    }
  }
}
