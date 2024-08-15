import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference personasCollection =
      FirebaseFirestore.instance.collection('personas');

  Future<List<Map<String, dynamic>>> obtenerDatos() async {
    try {
      QuerySnapshot querySnapshot = await personasCollection.get();
      return querySnapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo datos: $e');
    }
  }

  Future<bool> agregarPersona(String nombre, String numeroTelefono) async {
    try {
      // Verificar si ya existe una persona con el mismo nombre y número de teléfono
      QuerySnapshot existingPersona = await personasCollection
          .where('nombre', isEqualTo: nombre)
          .get();

      if (existingPersona.docs.isNotEmpty) {
        throw Exception(
            'La persona con el mismo nombre y número de teléfono ya existe.');
      }

      // Si no existe, agregar la persona
      await personasCollection.add({
        'nombre': nombre,
        'numeroTelefono': numeroTelefono,
      });
      return true;
    } catch (e) {
      throw Exception('Error agregando persona: $e');
    }
  }

  Future<bool> actualizarPersona(
      String id, String nombre, String numeroTelefono) async {
    try {
      await personasCollection.doc(id).update({
        'nombre': nombre,
        'numeroTelefono': numeroTelefono,
      });
      return true;
    } catch (e) {
      throw Exception('Error actualizando persona: $e');
    }
  }

  Future<bool> eliminarPersona(String id) async {
    try {
      await personasCollection.doc(id).delete();
      return true;
    } catch (e) {
      throw Exception('Error eliminando persona: $e');
    }
  }
}
