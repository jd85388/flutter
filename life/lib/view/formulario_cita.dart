import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormularioCita extends StatefulWidget {
  const FormularioCita({Key? key}) : super(key: key);

  @override
  _FormularioCitaState createState() => _FormularioCitaState();
}

class _FormularioCitaState extends State<FormularioCita> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  DateTime? _fechaSeleccionada;
  TimeOfDay? _horaSeleccionada;

  Future<void> _seleccionarFecha() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (fecha != null && fecha != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = fecha;
        _fechaController.text = DateFormat('yyyy-MM-dd').format(fecha);
      });
    }
  }

  Future<void> _seleccionarHora() async {
    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (hora != null && hora != _horaSeleccionada) {
      setState(() {
        _horaSeleccionada = hora;
        _horaController.text = hora.format(context);
      });
    }
  }

  void _guardarCita() {
    if (_formKey.currentState!.validate() && _fechaSeleccionada != null && _horaSeleccionada != null) {
      // Aquí guardas la cita en la base de datos
      final cita = {
        'nombre': _nombreController.text,
        'fecha': _fechaController.text,
        'hora': _horaController.text,
        'descripcion': _descripcionController.text,
      };
      print('Cita guardada: $cita');
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cita guardada exitosamente')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Cita'),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Complete la información de la cita',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Este campo es obligatorio' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Este campo es obligatorio' : null,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _seleccionarFecha,
                child: TextFormField(
                  controller: _fechaController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Fecha',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Este campo es obligatorio' : null,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _seleccionarHora,
                child: TextFormField(
                  controller: _horaController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Hora',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Este campo es obligatorio' : null,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _guardarCita,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar Cita'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
