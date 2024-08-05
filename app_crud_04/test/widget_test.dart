import 'package:app_crud_04/pages/product_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:app_crud_04/services/api_service.dart';
import 'package:flutter/material.dart';

@GenerateMocks([ApiService])
import 'widget_test.mocks.dart';

void main() {
  group('PaginaProductos tests', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
    });

    testWidgets('Muestra CircularProgressIndicator cuando se está cargando',
        (WidgetTester tester) async {
      when(mockApiService.obtenerDatos()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        MaterialApp(
          home: PaginaProductos(
            apiService: mockApiService,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Muestra lista de productos cuando se cargan los datos',
        (WidgetTester tester) async {
      when(mockApiService.obtenerDatos()).thenAnswer((_) async => [
            {'id': '1', 'nombre': 'Producto 1', 'precio': '10.0'},
            {'id': '2', 'nombre': 'Producto 2', 'precio': '20.0'},
          ]);

      await tester.pumpWidget(
        MaterialApp(
          home: PaginaProductos(
            apiService: mockApiService,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Producto 1'), findsOneWidget);
      expect(find.text('Producto 2'), findsOneWidget);
    });

    testWidgets('Muestra mensaje de error cuando ocurre una excepción',
        (WidgetTester tester) async {
      when(mockApiService.obtenerDatos())
          .thenThrow(Exception('Error de conexión'));

      await tester.pumpWidget(
        MaterialApp(
          home: PaginaProductos(
            apiService: mockApiService,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Exception: Error de conexión'), findsOneWidget);
    });
  });
}
