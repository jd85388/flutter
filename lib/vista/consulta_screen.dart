import 'package:flutter/material.dart';

class ConsultaScreen extends StatefulWidget {
  @override
  _ConsultaScreenState createState() => _ConsultaScreenState();
}

class _ConsultaScreenState extends State<ConsultaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _tipoConsulta = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  DateTime? _fecha;
  TimeOfDay? _hora;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Cita"),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: const Color(0xFFE6F7FB),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildInput(_nombre, "Nombre del paciente"),
              _buildInput(_tipoConsulta, "Tipo de consulta"),
              _buildDateTile(),
              _buildTimeTile(),
              _buildInput(_descripcion, "Descripción", maxLines: 3),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                onPressed: _guardarCita,
                child: const Text("Guardar"),
              )
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
        validator: (value) =>
            value == null || value.isEmpty ? "Campo obligatorio" : null,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildDateTile() {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(_fecha == null
          ? "Seleccionar fecha"
          : "Fecha: ${_fecha!.toLocal().toString().split(' ')[0]}"),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2100),
        );
        if (picked != null) setState(() => _fecha = picked);
      },
    );
  }

  Widget _buildTimeTile() {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(_hora == null
          ? "Seleccionar hora"
          : "Hora: ${_hora!.format(context)}"),
      trailing: const Icon(Icons.access_time),
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) setState(() => _hora = picked);
      },
    );
  }

  void _guardarCita() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cita registrada")),
      );
      Navigator.pop(context);
    }
  }
}
