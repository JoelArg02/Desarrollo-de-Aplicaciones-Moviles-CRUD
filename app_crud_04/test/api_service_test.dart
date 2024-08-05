import 'package:flutter_test/flutter_test.dart';
import 'package:app_crud_04/services/api_service.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Mock class
class MockClient extends Mock implements http.Client {}

void main() {
  group('ApiService', () {
    late ApiService apiService;
    late MockClient client;

    setUp(() {
      client = MockClient();
      apiService = ApiService();
    });

    test('obtenerDatos retorna una lista de datos', () async {
      when(client.get(Uri.parse('${apiService.baseUrl}get.php')))
          .thenAnswer((_) async => http.Response(jsonEncode([
                {'id': '1', 'nombre': 'Producto 1', 'precio': '10.0'},
                {'id': '2', 'nombre': 'Producto 2', 'precio': '20.0'},
              ]), 200));

      final datos = await apiService.obtenerDatos();
      expect(datos.length, 2);
      expect(datos[0]['nombre'], 'Producto 1');
    });

    test('agregarProducto retorna true en éxito', () async {
      when(client.post(
        Uri.parse('${apiService.baseUrl}create.php'),
        body: {'nombre': 'Producto 3', 'precio': '30.0'},
      )).thenAnswer((_) async => http.Response(jsonEncode({'mensaje': 'Exito'}), 200));

      final resultado = await apiService.agregarProducto('Producto 3', '30.0');
      expect(resultado, isTrue);
    });

    test('actualizarProducto retorna true en éxito', () async {
      when(client.put(
        Uri.parse('${apiService.baseUrl}put.php'),
        body: {'id': '1', 'nombre': 'Producto Actualizado', 'precio': '15.0'},
      )).thenAnswer((_) async => http.Response(jsonEncode({'mensaje': 'Exito'}), 200));

      final resultado = await apiService.actualizarProducto('1', 'Producto Actualizado', '15.0');
      expect(resultado, isTrue);
    });

    test('eliminarProducto retorna true en éxito', () async {
      when(client.delete(
        Uri.parse('${apiService.baseUrl}delete.php'),
        body: {'id': '1'},
      )).thenAnswer((_) async => http.Response(jsonEncode({'mensaje': 'Exito'}), 200));

      final resultado = await apiService.eliminarProducto('1');
      expect(resultado, isTrue);
    });
  });
}
