import 'package:flutter/material.dart';

class CitaScreen extends StatefulWidget {
  @override
  _CitaScreenState createState() => _CitaScreenState();
}

class _CitaScreenState extends State<CitaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _tipoController = TextEditingController();
  final _descripcionController = TextEditingController();
  DateTime? _fecha;
  TimeOfDay? _hora;

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fecha = picked;
      });
    }
  }

  Future<void> _seleccionarHora() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _hora = picked;
      });
    }
  }

  void _guardarCita() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cita registrada y correo enviado')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F7FB),
      appBar: AppBar(
        title: const Text('Registrar Cita'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildInput(_nombreController, 'Nombre del Médico o Lugar'),
              _buildInput(_tipoController, 'Tipo de Consulta'),
              _buildInput(_descripcionController, 'Descripción', maxLines: 2),
              const SizedBox(height: 16),
              _buildFechaSeleccion(),
              const SizedBox(height: 10),
              _buildHoraSeleccion(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarCita,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                child: const Text('Guardar Cita'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        maxLines: maxLines,
        validator: (value) =>
            value == null || value.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }

  Widget _buildFechaSeleccion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_fecha == null
            ? 'Selecciona la fecha'
            : 'Fecha: ${_fecha!.toLocal().toString().split(" ")[0]}'),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: _seleccionarFecha,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: const Text('Elegir Fecha', style: TextStyle(color: Colors.lightBlue)),
        ),
      ],
    );
  }

  Widget _buildHoraSeleccion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_hora == null
            ? 'Selecciona la hora'
            : 'Hora: ${_hora!.format(context)}'),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: _seleccionarHora,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: const Text('Elegir Hora', style: TextStyle(color: Colors.lightBlue)),
        ),
      ],
    );
  }
}
