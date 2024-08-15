import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference productosCollection =
      FirebaseFirestore.instance.collection('productos');

  Future<List<Map<String, dynamic>>> obtenerDatos() async {
    try {
      QuerySnapshot querySnapshot = await productosCollection.get();
      return querySnapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo datos: $e');
    }
  }

  Future<bool> agregarProducto(String nombre, String precio) async {
    try {
      await productosCollection.add({
        'nombre': nombre,
        'precio': precio,
      });
      return true;
    } catch (e) {
      throw Exception('Error agregando producto: $e');
    }
  }

  Future<bool> actualizarProducto(
      String id, String nombre, String precio) async {
    try {
      await productosCollection.doc(id).update({
        'nombre': nombre,
        'precio': precio,
      });
      return true;
    } catch (e) {
      throw Exception('Error actualizando producto: $e');
    }
  }

  Future<bool> eliminarProducto(String id) async {
    try {
      await productosCollection.doc(id).delete();
      return true;
    } catch (e) {
      throw Exception('Error eliminando producto: $e');
    }
  }
}