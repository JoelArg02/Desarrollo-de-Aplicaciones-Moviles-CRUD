import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String nombre;
  final String precio;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const ProductCard({
    Key? key,
    required this.nombre,
    required this.precio,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onUpdate,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
