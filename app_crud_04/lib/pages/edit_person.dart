import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_crud_04/services/api_service.dart';

class EditarPersona extends StatefulWidget {
  final String id;
  final String nombre;
  final String numeroTelefono;

  const EditarPersona({
    super.key,
    required this.id,
    required this.nombre,
    required this.numeroTelefono,
  });

  @override
  State<EditarPersona> createState() => _EditarPersonaState();
}

class _EditarPersonaState extends State<EditarPersona> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nombrePersona;
  late TextEditingController numeroTelefono;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    nombrePersona = TextEditingController(text: widget.nombre);
    numeroTelefono = TextEditingController(text: widget.numeroTelefono);
  }

  Future<bool> _actualizarPersona() async {
    try {
      return await apiService.actualizarPersona(
        widget.id,
        nombrePersona.text,
        numeroTelefono.text,
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
        title: const Text("Editar Persona"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nombrePersona,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person, color: Colors.lightGreen),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre de la persona no puede estar vacío';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: numeroTelefono,
                decoration: const InputDecoration(
                  labelText: 'Número de Teléfono',
                  prefixIcon: Icon(Icons.phone, color: Colors.lightGreen),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El número no puede estar vacío';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    bool success = await _actualizarPersona();
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
                icon: const Icon(Icons.save),
                label: const Text('Actualizar'),
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