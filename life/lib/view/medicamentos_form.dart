import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MedicamentosForm extends StatefulWidget {
  @override
  _MedicamentosFormState createState() => _MedicamentosFormState();
}

class _MedicamentosFormState extends State<MedicamentosForm> {
  final nombreController = TextEditingController();
  final horaController = TextEditingController();

  Future<void> guardarMedicamento() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/medicamentos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombreController.text,
        'hora': horaController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Guardado')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: nombreController, decoration: InputDecoration(labelText: 'Nombre')),
        TextField(controller: horaController, decoration: InputDecoration(labelText: 'Hora')),
        ElevatedButton(onPressed: guardarMedicamento, child: Text('Guardar'))
      ],
    );
  }
}
