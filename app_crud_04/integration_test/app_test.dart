import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app_crud_04/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba de integración de la app', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Lista de Productos'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Agregar producto'), findsOneWidget);
  });
}
