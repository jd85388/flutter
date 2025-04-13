import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Registro.dart';
import 'RecuperarInfo.dart';

class RecuperarPage extends StatefulWidget {
  const RecuperarPage({super.key});

  @override
  State<RecuperarPage> createState() => _RecuperarPageState();
}

class _RecuperarPageState extends State<RecuperarPage> {
  final TextEditingController emailController = TextEditingController();
  bool _cargando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFFE9F2FA),
                  child: Icon(Icons.health_and_safety,
                      color: Color(0xFF00B4D8), size: 30),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Life Reminder',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00B4D8),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Recuperar Contraseña',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Introduce tu correo o número de teléfono. '
                'Te enviaremos un enlace para restablecer la contraseña.',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Correo electrónico ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _cargando
                    ? null
                    : () async {
                        final email = emailController.text.trim();

                        if (email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Por favor ingresa un correo")),
                          );
                          return;
                        }

                        final url = Uri.parse(
                            'https://flutter-gaso.onrender.com/api/recuperacion');

                        setState(() {
                          _cargando = true;
                        });

                        try {
                          final response = await http.post(
                            url,
                            headers: {'Content-Type': 'application/json'},
                            body: jsonEncode({'correo': email}),
                          );

                          final data = jsonDecode(response.body);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                data['message'] ??
                                    (response.statusCode == 200
                                        ? 'Correo enviado'
                                        : 'No pudimos enviar el correo'),
                              ),
                            ),
                          );
                        } catch (err) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Error al conectar con el servidor")),
                          );
                        } finally {
                          setState(() {
                            _cargando = false;
                          });
                        }
                      },
                child: _cargando
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Enviar enlace',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const InformacionRecuperacionPage()));
                  },
                  child: const Text(
                    '¿No puedes cambiar la contraseña?',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6C4EBE),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: const <Widget>[
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("o"),
                ),
                Expanded(child: Divider(thickness: 1)),
              ]),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                label: const Text('Ingresar con Google',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // lógica de Google
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4267B2),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.facebook, color: Colors.white),
                label: const Text('Ingresar con Facebook',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // lógica de Facebook
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegistroPage()));
                  },
                  child: const Text(
                    '¿No tienes una cuenta? Regístrate aquí',
                    style: TextStyle(
                      color: Color(0xFF6C4EBE),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
