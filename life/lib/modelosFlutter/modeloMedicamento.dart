class Medicamento {
  final String? id; // ID opcional (viene de MongoDB como "_id")
  final String nombre;
  final DateTime fechaVencimiento;
  final String tipoMedicamento;
  final int cantidad;
  final String suministrarVia;
  final String instruccionSuministro;
  final String usuarioId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Medicamento({
    this.id,
    required this.nombre,
    required this.fechaVencimiento,
    required this.tipoMedicamento,
    required this.cantidad,
    required this.suministrarVia,
    required this.instruccionSuministro,
    required this.usuarioId,
    this.createdAt,
    this.updatedAt,
  });

  // Crear objeto desde JSON
  factory Medicamento.fromJson(Map<String, dynamic> json) {
    return Medicamento(
      id: json['_id'],
      nombre: json['nombre'],
      fechaVencimiento: DateTime.parse(json['fechaVencimiento']),
      tipoMedicamento: json['tipoMedicamento'],
      cantidad: json['cantidad'],
      suministrarVia: json['suministrarVia'],
      instruccionSuministro: json['instruccionSuministro'],
      usuarioId: json['usuarioId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  // Convertir a JSON para enviar al backend
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'nombre': nombre,
      'fechaVencimiento': fechaVencimiento.toIso8601String(),
      'tipoMedicamento': tipoMedicamento,
      'cantidad': cantidad,
      'suministrarVia': suministrarVia,
      'instruccionSuministro': instruccionSuministro,
      'usuarioId': usuarioId,
    };

    if (id != null) {
      data['_id'] = id;
    }

    return data;
  }
}
