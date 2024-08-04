import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AgregarProducto.dart';

class PaginaProductos extends StatefulWidget {
  const PaginaProductos({super.key});

  @override
  State<PaginaProductos> createState() => _PaginaProductosState();
}

class _PaginaProductosState extends State<PaginaProductos> {
  List _listdata = [];
  bool _loading = true;
  String _errorMessage = '';

  Future<void> _obtenerDatos() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });
    try {
      final respuesta =
          await http.get(Uri.parse("http://10.9.7.250:80/conexion.php"));
      if (respuesta.statusCode == 200) {
        final datos = jsonDecode(respuesta.body);
        if (datos is List) {
          setState(() {
            _listdata = datos;
            _loading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'La respuesta no es una lista de datos válida';
            _loading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Error del servidor: ${respuesta.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error de conexión: $e';
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _obtenerDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
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
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _obtenerDatos,
                  child: ListView.builder(
                    itemCount: _listdata.length,
                    itemBuilder: ((context, index) {
                      // Manejo de valores nulos
                      final nombre = _listdata[index]['nombre'] ?? 'Sin nombre';
                      final precio = _listdata[index]['precio']?.toString() ?? 'Sin precio';

                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: Icon(Icons.shopping_bag, color: Colors.lightGreen),
                          title: Text(
                            nombre,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Precio: $precio',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.deepOrange,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Agregarproducto()),
          );
          if (result == true) {
            await _obtenerDatos();
          }
        },
      ),
    );
  }
}
