import 'package:flutter/material.dart';
import 'package:app_crud_04/services/api_service.dart';

class EditarProducto extends StatefulWidget {
  final String id;
  final String nombre;
  final String precio;

  const EditarProducto({
    Key? key,
    required this.id,
    required this.nombre,
    required this.precio,
  }) : super(key: key);

  @override
  State<EditarProducto> createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nombreProducto;
  late TextEditingController precioProducto;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    nombreProducto = TextEditingController(text: widget.nombre);
    precioProducto = TextEditingController(text: widget.precio);
  }

  Future<bool> _actualizar() async {
    try {
      return await apiService.actualizarProducto(
        widget.id,
        nombreProducto.text,
        precioProducto.text,
      );
    } catch (e) {
      print("Excepción: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar producto"),
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
                    bool success = await _actualizar();
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
                                ? 'Datos actualizados exitosamente'
                                : 'Error al actualizar los datos'),
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
                label: Text('Actualizar'),
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
