import 'package:app_crud_04/components/product_cart.dart';
import 'package:app_crud_04/services/api_service.dart';
import 'package:flutter/material.dart';

import 'AgregarProducto.dart';
import 'edit_product.dart';

class PaginaProductos extends StatefulWidget {
  const PaginaProductos({super.key});

  @override
  State<PaginaProductos> createState() => _PaginaProductosState();
}

class _PaginaProductosState extends State<PaginaProductos> {
  final ApiService apiService = ApiService();
  List _listdata = [];
  bool _loading = true;
  String _errorMessage = '';

  Future<void> _obtenerDatos() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });
    try {
      final datos = await apiService.obtenerDatos();
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

  void _eliminarProducto(String id) async {
    try {
      bool success = await apiService.eliminarProducto(id);
      if (success) {
        _obtenerDatos();
      } else {
        throw Exception('Error al eliminar el producto');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _editarProducto(String id, String nombre, String precio) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditarProducto(id: id, nombre: nombre, precio: precio),
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
                      final id = _listdata[index]['id'].toString();
                      final nombre = _listdata[index]['nombre'] ?? 'Sin nombre';
                      final precio = _listdata[index]['precio']?.toString() ??
                          'Sin precio';

                      return Dismissible(
                        key: Key(id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.blue,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            _eliminarProducto(id);
                          } else if (direction == DismissDirection.endToStart) {
                            _editarProducto(id, nombre, precio);
                          }
                        },
                        child: ProductCard(
                          nombre: nombre,
                          precio: precio,
                          onDelete: () => _eliminarProducto(id),
                          onUpdate: () => _editarProducto(id, nombre, precio),
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
