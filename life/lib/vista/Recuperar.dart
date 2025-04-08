import 'package:flutter/material.dart';

class RecuperarPage extends StatelessWidget {
  const RecuperarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: Color(0xFFE9F2FA),
                  child: Icon(Icons.health_and_safety, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Life Reminder',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Recuperar contraseña',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Introduce tu correo electrónico o número de teléfono y '
                'enviaremos un enlace para que restaures la contraseña',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico o número de teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enlace de recuperación enviado")),
                  );
                },
                child: const Text(
                  'Enviar enlace de recuperación',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              const Center(child: Text('¿No puedes cambiar la contraseña?')),
              const SizedBox(height: 20),
              Row(children: const <Widget>[
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("O"),
                ),
                Expanded(child: Divider()),
              ]),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/registrar');
                },
                child: const Text('Crear cuenta nueva',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                label: const Text('Ingresar con Google',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // Lógica para Google
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.facebook, color: Colors.white),
                label: const Text('Ingresar con Facebook',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // Lógica para Facebook
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
