import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaCitasScreen extends StatefulWidget {
  const ListaCitasScreen({Key? key}) : super(key: key);

  @override
  State<ListaCitasScreen> createState() => _ListaCitasScreenState();
}

class _ListaCitasScreenState extends State<ListaCitasScreen> {
  List<Map<String, dynamic>> citas = [
    {
      'nombre': 'Dr. Juan Pérez',
      'tipoConsulta': 'Cardiología',
      'fecha': '2025-04-10',
      'hora': '10:00 AM',
      'descripcion': 'Chequeo general en Clínica Central',
    },
    {
      'nombre': 'Dra. Marta Ríos',
      'tipoConsulta': 'Control de diabetes',
      'fecha': '2025-04-12',
      'hora': '02:30 PM',
      'descripcion': 'Consulta en Hospital El Prado',
    },
  ];

  void eliminarCita(int index) {
    setState(() {
      citas.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cita eliminada')),
    );
  }

  void editarCita(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de editar aún en desarrollo')),
    );
  }

  String formatearFecha(String fecha, String hora) {
    try {
      final date = DateTime.parse(fecha);
      return '${DateFormat('EEEE dd MMMM', 'es_ES').format(date)} - $hora';
    } catch (_) {
      return '$fecha - $hora';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Citas Médicas'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: citas.isEmpty
          ? const Center(
              child: Text(
                'No hay citas registradas',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: citas.length,
              itemBuilder: (context, index) {
                final cita = citas[index];
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cita['tipoConsulta'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.black54),
                            const SizedBox(width: 6),
                            Text('Dr(a): ${cita['nombre']}'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: Colors.black54),
                            const SizedBox(width: 6),
                            Text(
                                'Fecha: ${formatearFecha(cita['fecha'], cita['hora'])}'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.description,
                                color: Colors.black54),
                            const SizedBox(width: 6),
                            Expanded(
                                child: Text('Notas: ${cita['descripcion']}')),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () => editarCita(index),
                              icon:
                                  const Icon(Icons.edit, color: Colors.orange),
                              label: const Text(
                                'Editar',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () => eliminarCita(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text(
                                'Eliminar',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
