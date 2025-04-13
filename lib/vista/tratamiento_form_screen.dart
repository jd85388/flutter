import 'package:flutter/material.dart';

class TratamientoFormScreen extends StatefulWidget {
  const TratamientoFormScreen({Key? key}) : super(key: key);

  @override
  State<TratamientoFormScreen> createState() => _TratamientoFormScreenState();
}

class _TratamientoFormScreenState extends State<TratamientoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _duracionController = TextEditingController();
  final TextEditingController _frecuenciaController = TextEditingController();

  void _guardarTratamiento() {
    if (_formKey.currentState!.validate()) {
      final tratamiento = {
        'nombre': _nombreController.text,
        'descripcion': _descripcionController.text,
        'duracion': _duracionController.text,
        'frecuencia': _frecuenciaController.text,
      };

      // Aquí debes guardar el tratamiento en la base de datos.
      print('Tratamiento guardado: $tratamiento');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tratamiento guardado exitosamente')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nuevo Tratamiento'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Completa la información del tratamiento',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 25),
              _buildTextField(_nombreController, 'Nombre del tratamiento', 'Ej: Rehabilitación física'),
              const SizedBox(height: 20),
              _buildTextField(_descripcionController, 'Descripción', 'Ej: Tratamiento para el dolor muscular', maxLines: 3),
              const SizedBox(height: 20),
              _buildTextField(_duracionController, 'Duración', 'Ej: 2 semanas'),
              const SizedBox(height: 20),
              _buildTextField(_frecuenciaController, 'Frecuencia', 'Ej: 3 veces al día'),
              const SizedBox(height: 35),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 4,
                    shadowColor: Colors.blue[200],
                  ),
                  onPressed: _guardarTratamiento,
                  icon: const Icon(Icons.save_alt_rounded, size: 24),
                  label: const Text(
                    'Guardar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? 'Este campo es obligatorio' : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
