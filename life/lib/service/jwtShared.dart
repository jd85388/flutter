import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void cambiarRolAPremium(BuildContext context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'No hay token de usuario, por favor inicia sesión nuevamente')),
      );
      return;
    }

    final decodedToken = jsonDecode(utf8
        .decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))));
    final userId = decodedToken['userId'];

    final response = await http.put(
      Uri.parse('https://flutter-gaso.onrender.com/api/CambioRol'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'userId': userId,
        'nuevoRol': 'premium',
      }),
    );
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      await prefs.setString('rol', 'premium');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Ahora eres usuario premium! 🎉')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cambiar el rol')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error de red: $e')),
    );
  }
}

Future<bool> esUsuarioPremium() async {
  final prefs = await SharedPreferences.getInstance();
  bool? esPremium = prefs.getBool('isPremium');
  return esPremium ?? false;
}
