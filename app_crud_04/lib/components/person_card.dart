import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String nombre;
  final String numeroTelefono;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const PersonCard({
    super.key,
    required this.nombre,
    required this.numeroTelefono,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.lightGreen),
        title: Text(
          nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Teléfono: $numeroTelefono',
          style: TextStyle(color: Colors.grey[700]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onUpdate,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}