// lib/modelos/usuario.dart

class Usuario {
  final String? id;
  final String nombre;
  final String correo;
  final int telefono;
  final String? genero;
  final String? password; // Solo para login o registro

  Usuario({
    this.id,
    required this.nombre,
    required this.correo,
    required this.telefono,
    this.genero,
    this.password,
  });

  // Desde JSON a objeto Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'],
      nombre: json['nombre'],
      correo: json['correo'],
      telefono: json['telefono'],
      genero: json['genero'],
      // La contraseña no se incluye por seguridad
    );
  }

  // Desde objeto Usuario a JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
    };

    if (genero != null) data['genero'] = genero;
    if (password != null) data['contraseña'] = password;
    if (id != null) data['_id'] = id;

    return data;
  }
}
