import 'package:app_crud_04/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AgregarPersona extends StatefulWidget {
  const AgregarPersona({super.key});

  @override
  State<AgregarPersona> createState() => _AgregarPersonaState();
}

bool isValidPersonName(String? personName) {
  return !(personName == null ||
      personName.isEmpty ||
      personName.contains(RegExp('[^a-zA-Z0-9\\s]')));
}

bool isValidPhoneNumber(String? phoneNumber) {
  return !(phoneNumber == null ||
      phoneNumber.isEmpty ||
      double.tryParse(phoneNumber) == null);
}

class _AgregarPersonaState extends State<AgregarPersona> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombrePersona = TextEditingController();
  TextEditingController numeroTelefono = TextEditingController();
  final ApiService apiService = ApiService();

  Future<bool> _agregarPersona() async {
    try {
      return await apiService.agregarPersona(
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
        title: const Text("Agregar Persona"),
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
                  if (!isValidPersonName(value)) {
                    return 'El nombre de la persona no puede estar vacío o contener caracteres especiales';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: numeroTelefono,
                decoration: const InputDecoration(
                  labelText: 'Número',
                  prefixIcon: Icon(Icons.phone, color: Colors.lightGreen),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (!isValidPhoneNumber(value)) {
                    return 'El número de teléfono no puede estar vacío o contener caracteres no numéricos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    bool success = await _agregarPersona();
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