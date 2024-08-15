import 'package:app_crud_04/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Agregarproducto extends StatefulWidget {
  const Agregarproducto({super.key});

  @override
  State<Agregarproducto> createState() => _AgregarproductoState();
}

bool isValidProductName(String? productName) {
  return !(productName == null ||
      productName.isEmpty ||
      productName.contains(RegExp('[^a-zA-Z0-9]')));
}

bool isValidProductPrice(String? productPrice) {
  return !(productPrice == null ||
      productPrice.isEmpty ||
      double.tryParse(productPrice) == null);
}

class _AgregarproductoState extends State<Agregarproducto> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreProducto = TextEditingController();
  TextEditingController precioProducto = TextEditingController();
  final ApiService apiService = ApiService();

  Future<bool> _agregar() async {
    try {
      return await apiService.agregarProducto(
        nombreProducto.text,
        precioProducto.text,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Excepción: $e");
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar persona"),
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
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon:
                      Icon(Icons.shopping_bag, color: Colors.lightGreen),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                ),
                validator: (value) {
                  if (!isValidProductName(value)) {
                    return 'El nombre de la persona no puede estar vacío o contener caracteres especiales';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: precioProducto,
                decoration: const InputDecoration(
                  labelText: 'Número',
                  prefixIcon:
                      Icon(Icons.attach_money, color: Colors.lightGreen),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (!isValidProductPrice(value)) {
                    return 'El número de la persona no puede estar vacío';
                  }
                  /* if (double.tryParse(value) == null) {
                    return 'Ingrese un precio válido';
                  } */
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    bool success = await _agregar();
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              success ? Icons.check_circle : Icons.error,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(success
                                ? 'Datos guardados exitosamente'
                                : 'Error al guardar los datos'),
                          ],
                        ),
                        backgroundColor:
                            success ? Colors.lightGreen : Colors.red,
                      ),
                    );
                    if (success) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true);
                    }
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar'),
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
