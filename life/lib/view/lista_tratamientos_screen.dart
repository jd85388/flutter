import 'package:flutter/material.dart';

class ListaTratamientosScreen extends StatefulWidget {
  const ListaTratamientosScreen({Key? key}) : super(key: key);

  @override
  State<ListaTratamientosScreen> createState() =>
      _ListaTratamientosScreenState();
}

class _ListaTratamientosScreenState extends State<ListaTratamientosScreen> {
  // Simulación de tratamientos (aquí deberías usar la base de datos)
  List<Map<String, String>> tratamientos = [
    {
      'nombre': 'Fisioterapia',
      'descripcion': 'Tratamiento para mejorar movilidad',
      'duracion': '2 semanas',
      'frecuencia': '3 veces por semana',
    },
    {
      'nombre': 'Tratamiento Respiratorio',
      'descripcion': 'Mejorar capacidad pulmonar',
      'duracion': '1 mes',
      'frecuencia': 'Diariamente',
    },
  ];

  void eliminarTratamiento(int index) {
    setState(() {
      tratamientos.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tratamiento eliminado')),
    );
  }

  void editarTratamiento(int index) {
    // Aquí podrías navegar a una pantalla de edición y pasar los datos
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Función de editar en desarrollo')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mis Tratamientos'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: tratamientos.isEmpty
          ? const Center(
              child: Text('No hay tratamientos registrados',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tratamientos.length,
              itemBuilder: (context, index) {
                final tratamiento = tratamientos[index];
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tratamiento['nombre'] ?? '',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent)),
                        const SizedBox(height: 10),
                        Text('Descripción: ${tratamiento['descripcion']}'),
                        Text('Duración: ${tratamiento['duracion']}'),
                        Text('Frecuencia: ${tratamiento['frecuencia']}'),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () => editarTratamiento(index),
                              icon:
                                  const Icon(Icons.edit, color: Colors.orange),
                              label: const Text('Editar',
                                  style: TextStyle(color: Colors.orange)),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () => eliminarTratamiento(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text('Eliminar',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
