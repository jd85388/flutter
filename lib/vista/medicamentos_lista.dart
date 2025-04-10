import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MedicamentosLista extends StatefulWidget {
  @override
  _MedicamentosListaState createState() => _MedicamentosListaState();
}

class _MedicamentosListaState extends State<MedicamentosLista> {
  List medicamentos = [];

  Future<void> cargarMedicamentos() async {
    final response = await http.get(Uri.parse('http://localhost:3000/medicamentos'));
    if (response.statusCode == 200) {
      setState(() {
        medicamentos = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cargarMedicamentos();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medicamentos.length,
      itemBuilder: (context, index) {
        final med = medicamentos[index];
        return ListTile(
          title: Text(med['nombre']),
          subtitle: Text(med['hora']),
        );
      },
    );
  }
}
