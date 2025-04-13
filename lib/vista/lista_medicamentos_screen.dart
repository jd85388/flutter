import 'package:flutter/material.dart';

class ListaMedicamentosScreen extends StatefulWidget {
  const ListaMedicamentosScreen({Key? key}) : super(key: key);

  @override
  State<ListaMedicamentosScreen> createState() => _ListaMedicamentosScreenState();
}

class _ListaMedicamentosScreenState extends State<ListaMedicamentosScreen> {
  // Lista simulada de medicamentos (en el futuro puedes obtenerla desde tu backend)
  List<Map<String, String>> medicamentos = [
    {
      'nombre': 'Paracetamol',
      'dosis': '500mg',
      'frecuencia': 'Cada 8 horas',
      'duracion': '5 días',
    },
    {
      'nombre': 'Ibuprofeno',
      'dosis': '400mg',
      'frecuencia': 'Cada 12 horas',
      'duracion': '7 días',
    },
  ];

  void eliminarMedicamento(int index) {
    setState(() {
      medicamentos.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medicamento eliminado')),
    );
  }

  void editarMedicamento(int index) {
    // En el futuro: navegar a formulario de edición
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Función de editar en desarrollo')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mis Medicamentos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: medicamentos.isEmpty
          ? const Center(
              child: Text(
                'No hay medicamentos registrados',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: medicamentos.length,
              itemBuilder: (context, index) {
                final medicamento = medicamentos[index];
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicamento['nombre'] ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('Dosis: ${medicamento['dosis']}'),
                        Text('Frecuencia: ${medicamento['frecuencia']}'),
                        Text('Duración: ${medicamento['duracion']}'),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () => editarMedicamento(index),
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              label: const Text('Editar', style: TextStyle(color: Colors.orange)),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () => eliminarMedicamento(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text('Eliminar', style: TextStyle(color: Colors.red)),
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
