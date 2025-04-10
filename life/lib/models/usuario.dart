class Usuario {
  final String? id;
  final String nombre;
  final String apellido;
  final String telefono;
  final String correo;
  final String age;
  final String password;

  Usuario({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.correo,
    required this.age,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': nombre,
      'surname': apellido,
      'telephone': telefono,
      'email': correo,
      'age': age,
      'password': password,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'],
      nombre: json['name'],
      apellido: json['surname'],
      telefono: json['telephone'],
      correo: json['email'],
      age: json['age'],
      password: '',
    );
  }
}
