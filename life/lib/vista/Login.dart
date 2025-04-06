// login.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Registro.dart';
import 'Recuperar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _cargando = false;

  Future<void> _iniciarSesion() async {
    setState(() {
      _cargando = true;
    });

    final url = Uri.parse('http://localhost:3000/auth/login'); // Reemplaza por tu IP si estás en físico
    final respuesta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'correo': _correoController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _cargando = false;
    });

    if (respuesta.statusCode == 200) {
      final data = jsonDecode(respuesta.body);
      final token = data['token'];
      // Aquí puedes guardar el token en SharedPreferences y navegar a la siguiente pantalla
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesión exitoso')),
      );
      // Navigator.push(...);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Life Reminder"),
        leading: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/logoN.png',
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Error al cargar el logo',
                    style: TextStyle(color: Colors.red),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Life Reminder',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const Center(
              child: Text(
                'Life Reminder cuida tu salud',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _correoController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: _cargando ? null : _iniciarSesion,
              child: _cargando
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Ingresar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistroPage()),
                );
              },
              child: const Text("Registrarme"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RecuperarPage()),
                  );
                },
                child: const Text("¿Olvidaste la contraseña?"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Google login
              },
              icon: const Icon(Icons.g_translate),
              label: const Text("Continuar con Google"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Facebook login
              },
              icon: const Icon(Icons.facebook),
              label: const Text("Continuar con Facebook"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
