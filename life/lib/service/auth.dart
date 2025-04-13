import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class apiUsuario {
  final String baseUrl = "https://flutter-gaso.onrender.com/api";

  Future<bool> registrarUsuario(Usuario usuario) async {
    final url = Uri.parse('$baseUrl/registro');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Error al registrar: ${response.body}');
      return false;
    }
  }

  Future<String?> login(String correo, String password) async {
    final url = Uri.parse('$baseUrl/inicio');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': correo, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final token = jsonData['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return token;
    } else {
      print('Error al iniciar sesión: ${response.body}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> obtenerPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("No hay token guardado");
      return null;
    }

    final url = Uri.parse('$baseUrl/profile');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error al obtener perfil: ${response.body}");
      return null;
    }
  }
}
