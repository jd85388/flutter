import 'package:flutter/material.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Preferencias Generales',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          configuracionItem(
              icon: Icons.notifications, titulo: 'Notificaciones'),
          configuracionItem(icon: Icons.lock, titulo: 'Privacidad'),
          configuracionItem(icon: Icons.language, titulo: 'Idioma'),
          configuracionItem(icon: Icons.color_lens, titulo: 'Tema de la App'),
          configuracionItem(icon: Icons.info, titulo: 'Acerca de'),
          configuracionItem(icon: Icons.logout, titulo: 'Cerrar sesión'),
        ],
      ),
    );
  }

  Widget configuracionItem({required IconData icon, required String titulo}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(titulo),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
