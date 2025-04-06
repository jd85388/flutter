// backend/models/medicamento.ts

import { Schema, model } from 'mongoose';

const medicamentoSchema = new Schema({
  nombre: { type: String, required: true },
  fechaVencimiento: { type: Date, required: true },
  tipoMedicamento: { type: String, required: true },
  cantidad: { type: Number, required: true },
  suministrarVia: { type: String, required: true },
  instruccionSuministro: { type: String, required: true },
  usuarioId: { type: Schema.Types.ObjectId, ref: 'Usuario', required: true } // vínculo con usuario
}, {
  timestamps: true // agrega createdAt y updatedAt automáticamente
});

export default model('Medicamento', medicamentoSchema);
