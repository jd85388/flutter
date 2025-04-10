import 'package:flutter/material.dart';

class FormularioTratamiento extends StatefulWidget {
  const FormularioTratamiento({Key? key}) : super(key: key);

  @override
  State<FormularioTratamiento> createState() => _FormularioTratamientoState();
}

class _FormularioTratamientoState extends State<FormularioTratamiento> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _duracionController = TextEditingController();

  void _guardarTratamiento() {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes integrar la lógica para guardar en base de datos
      final tratamiento = {
        'nombre': _nombreController.text.trim(),
        'descripcion': _descripcionController.text.trim(),
        'duracion': _duracionController.text.trim(),
      };

      print('Tratamiento guardado: $tratamiento');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tratamiento guardado exitosamente')),
      );

      _formKey.currentState!.reset();
      _nombreController.clear();
      _descripcionController.clear();
      _duracionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Tratamiento'),
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
                'Registrar tratamiento',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Campo Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del tratamiento',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medical_services),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el nombre del tratamiento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Descripción
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Agrega una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Duración
              TextFormField(
                controller: _duracionController,
                decoration: const InputDecoration(
                  labelText: 'Duración (en días)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa la duración';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Debe ser un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Botón Guardar
              ElevatedButton.icon(
                onPressed: _guardarTratamiento,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Tratamiento'),
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
