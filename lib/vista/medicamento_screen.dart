import 'package:flutter/material.dart';

class MedicamentoScreen extends StatefulWidget {
  @override
  _MedicamentoScreenState createState() => _MedicamentoScreenState();
}

class _MedicamentoScreenState extends State<MedicamentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _tipoController = TextEditingController();
  final _viaController = TextEditingController();
  final _instruccionController = TextEditingController();
  final _cantidadController = TextEditingController();
  DateTime? _fechaVencimiento;

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fechaVencimiento = picked;
      });
    }
  }

  void _guardarMedicamento() {
    if (_formKey.currentState!.validate()) {
      // Aquí irá la lógica para guardar en backend
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Medicamento guardado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Medicamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del Medicamento'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo de Medicamento'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _cantidadController,
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _viaController,
                decoration: InputDecoration(labelText: 'Vía de suministro'),
              ),
              TextFormField(
                controller: _instruccionController,
                decoration: InputDecoration(labelText: 'Instrucciones'),
              ),
              SizedBox(height: 16),
              Text(_fechaVencimiento == null
                  ? 'Selecciona la fecha de vencimiento'
                  : 'Vence: ${_fechaVencimiento!.toLocal()}'.split(' ')[0]),
              ElevatedButton(
                onPressed: _seleccionarFecha,
                child: Text('Elegir Fecha'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarMedicamento,
                child: Text('Guardar Medicamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
