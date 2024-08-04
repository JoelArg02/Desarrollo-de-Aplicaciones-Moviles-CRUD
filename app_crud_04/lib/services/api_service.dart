import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://192.168.68.102:80/";

  Future<List> obtenerDatos() async {
    try {
      final respuesta = await http.get(Uri.parse("${baseUrl}get.php"));
      if (respuesta.statusCode == 200) {
        return jsonDecode(respuesta.body) as List;
      } else {
        throw Exception('Error del servidor: ${respuesta.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<bool> agregarProducto(String nombre, String precio) async {
    try {
      final respuesta = await http.post(
        Uri.parse("${baseUrl}create.php"),
        body: {
          'nombre': nombre,
          'precio': precio,
        },
      );

      if (respuesta.statusCode == 200) {
        final body = jsonDecode(respuesta.body);
        return body['mensaje'] == 'Exito';
      } else {
        throw Exception('Error del servidor: ${respuesta.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción: $e');
    }
  }

  Future<bool> actualizarProducto(
      String id, String nombre, String precio) async {
    try {
      final respuesta = await http.put(
        Uri.parse("${baseUrl}put.php"),
        body: {
          'id': id,
          'nombre': nombre,
          'precio': precio,
        },
      );

      if (respuesta.statusCode == 200) {
        final body = jsonDecode(respuesta.body);
        return body['mensaje'] == 'Exito';
      } else {
        throw Exception('Error del servidor: ${respuesta.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción: $e');
    }
  }

  Future<bool> eliminarProducto(String id) async {
    try {
      final respuesta = await http.delete(
        Uri.parse("${baseUrl}delete.php"),
        body: {
          'id': id,
        },
      );

      if (respuesta.statusCode == 200) {
        final body = jsonDecode(respuesta.body);
        return body['mensaje'] == 'Exito';
      } else {
        throw Exception('Error del servidor: ${respuesta.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción: $e');
    }
  }
}
