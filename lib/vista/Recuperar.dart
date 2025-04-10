import 'package:flutter/material.dart';
import 'Registro.dart';
import 'RecuperarInfo.dart';

class RecuperarPage extends StatelessWidget {
  const RecuperarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

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
                  child: Icon(Icons.health_and_safety, color: Color(0xFF00B4D8), size: 30),
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
                  labelText: 'Correo electrónico o número de teléfono',
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enlace de recuperación enviado")),
                  );
                },
                child: const Text(
                  'Enviar enlace de recuperación',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),

              // Enlace interactivo "¿No puedes cambiar la contraseña?"
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const InformacionRecuperacionPage()));
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

              // Botón Google
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                label: const Text('Ingresar con Google', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // lógica de Google
                },
              ),
              const SizedBox(height: 10),

              // Botón Facebook
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4267B2),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.facebook, color: Colors.white),
                label: const Text('Ingresar con Facebook', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // lógica de Facebook
                },
              ),
              const SizedBox(height: 20),

              // Enlace "¿No tienes una cuenta? Regístrate aquí"
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistroPage()));
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
