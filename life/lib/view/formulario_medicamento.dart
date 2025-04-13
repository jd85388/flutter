// ... (tus imports se mantienen igual)
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life/utils/notificaciones.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormularioMedicamento extends StatefulWidget {
  const FormularioMedicamento({Key? key}) : super(key: key);

  @override
  State<FormularioMedicamento> createState() => _FormularioMedicamentoState();
}

class _FormularioMedicamentoState extends State<FormularioMedicamento> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _dosisController = TextEditingController();
  final _frecuenciaController = TextEditingController();
  final _fechaFinController = TextEditingController();
  final _viaSuministroController = TextEditingController();

  DateTime? _fechaFin;
  TimeOfDay? _horaFrecuencia;

  final String apiUrl = 'http://192.168.80.11:3000/api/registrarMedicamento';

  // 👇 ID fijo temporalmente
  final String usuarioId = '661d3a43b031dc91f7f01a70';

  Future<void> _seleccionarFechaFin() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (fecha != null) {
      setState(() {
        _fechaFin = fecha;
        _fechaFinController.text = DateFormat('yyyy-MM-dd').format(fecha);
      });
    }
  }

  Future<void> _seleccionarHoraFrecuencia() async {
    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      setState(() {
        _horaFrecuencia = hora;
        final now = DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, hora.hour, hora.minute);
        _frecuenciaController.text = DateFormat('hh:mm a').format(dt);
      });
    }
  }

  void _guardarMedicamento() async {
    if (_formKey.currentState!.validate()) {
      if (_fechaFin != null && _fechaFin!.isBefore(DateTime.now())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La fecha de fin debe ser futura')),
        );
        return;
      }

      final medicamento = {
        'nombre': _nombreController.text.trim(),
        'dosis': _dosisController.text.trim(),
        'frecuencia': _frecuenciaController.text.trim(),
        'fechaFin': _fechaFinController.text.trim(),
        'viaSuministro': _viaSuministroController.text.trim(),
        'usuarioId': usuarioId, // ✅ Se agrega usuarioId aquí
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(medicamento),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Medicamento registrado exitosamente')),
          );

          _formKey.currentState!.reset();
          _nombreController.clear();
          _dosisController.clear();
          _frecuenciaController.clear();
          _fechaFinController.clear();
          _viaSuministroController.clear();
          setState(() {
            _fechaFin = null;
            _horaFrecuencia = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al guardar: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Medicamento'),
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
                'Registrar medicamento',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTextField(_nombreController, 'Nombre', Icons.medication),
              const SizedBox(height: 16),
              _buildTextField(_dosisController, 'Dosis', Icons.tips_and_updates),
              const SizedBox(height: 16),
              TextFormField(
                controller: _frecuenciaController,
                readOnly: true,
                onTap: _seleccionarHoraFrecuencia,
                decoration: const InputDecoration(
                  labelText: '¿A qué hora debes tomarlo?',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Seleccione la hora' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fechaFinController,
                readOnly: true,
                onTap: _seleccionarFechaFin,
                decoration: const InputDecoration(
                  labelText: 'Fecha fin',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Seleccione la fecha fin' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(_viaSuministroController, 'Vía de suministro', Icons.local_hospital),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _guardarMedicamento,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Medicamento'),
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

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Ingrese $label' : null,
    );
  }
}
