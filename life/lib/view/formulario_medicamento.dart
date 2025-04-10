import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life/utils/notificaciones.dart'; // Asegúrate de que la ruta sea correcta

class FormularioMedicamento extends StatefulWidget {
  const FormularioMedicamento({Key? key}) : super(key: key);

  @override
  State<FormularioMedicamento> createState() => _FormularioMedicamentoState();
}

class _FormularioMedicamentoState extends State<FormularioMedicamento> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _fechaController = TextEditingController();
  final _tipoController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _dosisController = TextEditingController();
  final _viaController = TextEditingController();
  final _instruccionesController = TextEditingController();

  DateTime? _fechaAlarma;

  Future<void> _seleccionarFecha() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (fecha != null) {
      setState(() {
        _fechaAlarma = fecha;
        _fechaController.text = DateFormat('yyyy-MM-dd').format(fecha);
      });
    }
  }

  void _guardarMedicamento() async {
    if (_formKey.currentState!.validate()) {
      final medicamento = {
        'nombre': _nombreController.text.trim(),
        'fechaVencimiento': _fechaController.text.trim(),
        'tipoMedicamento': _tipoController.text.trim(),
        'cantidad': int.tryParse(_cantidadController.text.trim()) ?? 0,
        'dosis': _dosisController.text.trim(),
        'suministrarVia': _viaController.text.trim(),
        'instruccionSuministro': _instruccionesController.text.trim(),
      };

      print("Medicamento guardado: $medicamento");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicamento registrado exitosamente')),
      );

      _formKey.currentState!.reset();
      _nombreController.clear();
      _fechaController.clear();
      _tipoController.clear();
      _cantidadController.clear();
      _dosisController.clear();
      _viaController.clear();
      _instruccionesController.clear();
      setState(() {
        _fechaAlarma = null;
      });
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
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medication),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese el nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fechaController,
                readOnly: true,
                onTap: _seleccionarFecha,
                decoration: const InputDecoration(
                  labelText: 'Fecha de vencimiento',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Seleccione la fecha'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tipoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de medicamento',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese el tipo' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cantidadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese la cantidad'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dosisController,
                decoration: const InputDecoration(
                  labelText: 'Dosis',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.tips_and_updates),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese la dosis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _viaController,
                decoration: const InputDecoration(
                  labelText: 'Vía de suministro',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medical_information),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese la vía' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instruccionesController,
                decoration: const InputDecoration(
                  labelText: 'Instrucciones',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.list),
                ),
                maxLines: 3,
              ),
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
}
