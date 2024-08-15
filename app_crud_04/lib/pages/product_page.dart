import 'package:app_crud_04/components/person_card.dart';  // Asegúrate de tener un archivo 'person_card.dart'
import 'package:app_crud_04/services/api_service.dart';
import 'package:flutter/material.dart';

import 'add_person.dart';  // Asegúrate de tener un archivo 'add_person.dart'
import 'edit_person.dart';  // Asegúrate de tener un archivo 'edit_person.dart'

class PaginaPersonas extends StatefulWidget {
  final ApiService apiService;
  PaginaPersonas({super.key, ApiService? apiService})
      : apiService = apiService ?? ApiService();

  @override
  State<PaginaPersonas> createState() => _PaginaPersonasState();
}

class _PaginaPersonasState extends State<PaginaPersonas> {
  List _listdata = [];
  bool _loading = true;
  String _errorMessage = '';

  Future<void> _obtenerDatos() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });
    try {
      final datos = await widget.apiService.obtenerDatos();
      setState(() {
        _listdata = datos;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _obtenerDatos();
    super.initState();
  }

  void _eliminarPersona(String id) async {
    try {
      bool success = await widget.apiService.eliminarPersona(id);
      if (success) {
        _obtenerDatos();
      } else {
        throw Exception('Error al eliminar la persona');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _editarPersona(String id, String nombre, String numeroTelefono) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditarPersona(id: id, nombre: nombre, numeroTelefono: numeroTelefono),
      ),
    );
    if (result == true) {
      _obtenerDatos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personas'),
        backgroundColor: Colors.lightGreen,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _obtenerDatos,
                  child: ListView.builder(
                    itemCount: _listdata.length,
                    itemBuilder: ((context, index) {
                      final id = _listdata[index]['id'].toString();
                      final nombre = _listdata[index]['nombre'] ?? 'Sin nombre';
                      final numeroTelefono = _listdata[index]['numeroTelefono']?.toString() ??
                          'Sin número';

                      return Dismissible(
                        key: Key(id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.blue,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            _eliminarPersona(id);
                          } else if (direction == DismissDirection.endToStart) {
                            _editarPersona(id, nombre, numeroTelefono);
                          }
                        },
                        child: PersonCard(
                          nombre: nombre,
                          numeroTelefono: numeroTelefono,
                          onDelete: () => _eliminarPersona(id),
                          onUpdate: () => _editarPersona(id, nombre, numeroTelefono),
                        ),
                      );
                    }),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 30),
        backgroundColor: Colors.grey,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AgregarPersona()),
          );
          if (result == true) {
            await _obtenerDatos();
          }
        },
      ),
    );
  }
}