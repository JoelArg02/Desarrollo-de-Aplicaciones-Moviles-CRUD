import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_crud_04/pages/product_page.dart';
import 'package:app_crud_04/services/api_service.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  testWidgets('Página de productos muestra datos correctamente', (WidgetTester tester) async {
    final mockApiService = MockApiService();
    when(mockApiService.obtenerDatos()).thenAnswer((_) async => [
      {'id': '1', 'nombre': 'Producto 1', 'precio': '10.0'},
    ]);

    await tester.pumpWidget(MaterialApp(
      home: PaginaProductos(),
    ));

    await tester.pump();

    expect(find.text('Producto 1'), findsOneWidget);
    expect(find.text('10.0'), findsOneWidget);
  });
}
