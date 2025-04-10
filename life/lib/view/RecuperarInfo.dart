import 'package:flutter/material.dart';

class InformacionRecuperacionPage extends StatelessWidget {
  const InformacionRecuperacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B4D8),
        title: const Text("¿Tienes problemas?",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 20),
            Text(
              'Soluciones comunes:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text("• Verifica que ingresaste correctamente tu correo o número."),
            SizedBox(height: 10),
            Text("• Revisa tu carpeta de spam o promociones."),
            SizedBox(height: 10),
            Text("• Espera unos minutos antes de volver a intentarlo."),
            SizedBox(height: 20),
            Text(
              'Si aún no puedes acceder, por favor contacta a soporte.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
