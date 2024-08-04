import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Agregarproducto extends StatefulWidget {
  const Agregarproducto({super.key});

  @override
  State<Agregarproducto> createState() => _AgregarproductoState();
}

class _AgregarproductoState extends State<Agregarproducto> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreProducto = TextEditingController();
  TextEditingController precioProducto = TextEditingController();

  Future<bool> _agregar() async {
    try {
      final respuesta = await http.post(
        Uri.parse('http://10.9.7.250:80/create.php'),
        body: {
          'nombre': nombreProducto.text,
          'precio': precioProducto.text,
        },
      );

      if (respuesta.statusCode == 200) {
        final body = jsonDecode(respuesta.body);
        print('Respuesta del servidor: $body');  // Imprime la respuesta completa del servidor
        if (body['mensaje'] == 'Exito') {
          return true;
        } else {
          print('Error: ${body['mensaje']}');
          if (body.containsKey('error')) {
            print('Detalles del error: ${body['error']}');
          }
        }
      } else {
        print('Respuesta del servidor: ${respuesta.statusCode}');
      }
    } catch (e) {
      print("Excepción: $e");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar producto"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nombreProducto,
                decoration: InputDecoration(
                  labelText: 'Nombre producto',
                  prefixIcon: Icon(Icons.shopping_bag, color: Colors.lightGreen),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre del producto no puede estar vacío';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: precioProducto,
                decoration: InputDecoration(
                  labelText: 'Precio producto',
                  prefixIcon: Icon(Icons.attach_money, color: Colors.lightGreen),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El precio del producto no puede estar vacío';
                  }
                  // Validar que el valor sea un número válido
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un precio válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    bool success = await _agregar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              success ? Icons.check_circle : Icons.error,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(success
                                ? 'Datos guardados exitosamente'
                                : 'Error al guardar los datos'),
                          ],
                        ),
                        backgroundColor: success ? Colors.lightGreen : Colors.red,
                      ),
                    );
                    if (success) {
                      Navigator.pop(context, true);
                    }
                  }
                },
                icon: Icon(Icons.save),
                label: Text('Guardar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
