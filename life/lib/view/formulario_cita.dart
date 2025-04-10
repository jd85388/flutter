import 'package:flutter/material.dart';

class FormularioCita extends StatefulWidget {
  const FormularioCita({Key? key}) : super(key: key);

  @override
  State<FormularioCita> createState() => _FormularioCitaState();
}

class _FormularioCitaState extends State<FormularioCita> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _tipoController = TextEditingController();
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();
  final _descripcionController = TextEditingController();

  Future<void> _seleccionarFecha() async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (fecha != null) {
      _fechaController.text = fecha.toIso8601String().split('T').first;
    }
  }

  Future<void> _seleccionarHora() async {
    TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      _horaController.text = hora.format(context);
    }
  }

  void _guardarCita() {
    if (_formKey.currentState!.validate()) {
      final cita = {
        'nombre': _nombreController.text.trim(),
        'tipoConsulta': _tipoController.text.trim(),
        'fecha': _fechaController.text.trim(),
        'hora': _horaController.text.trim(),
        'descripcion': _descripcionController.text.trim(),
      };

      print("Cita guardada: $cita");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cita registrada exitosamente')),
      );

      _formKey.currentState!.reset();
      _nombreController.clear();
      _tipoController.clear();
      _fechaController.clear();
      _horaController.clear();
      _descripcionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Cita'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Registrar cita médica',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del médico o especialista',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese el nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tipoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de consulta',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_hospital),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese el tipo de consulta'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fechaController,
                readOnly: true,
                onTap: _seleccionarFecha,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Seleccione la fecha'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _horaController,
                readOnly: true,
                onTap: _seleccionarHora,
                decoration: const InputDecoration(
                  labelText: 'Hora',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Seleccione la hora'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _guardarCita,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Cita'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
