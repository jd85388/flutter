// src/models/medicamento.ts
import { Schema, model } from 'mongoose';

const medicamentoSchema = new Schema(
  {
    usuarioId: {
      type: Schema.Types.ObjectId,
      ref: 'Usuario',
      required: true,
    },
    nombre: {
      type: String,
      required: true,
    },
    dosis: {
      type: String,
      required: true,
    },
    frecuencia: {
      type: String,
      required: true,
    },
    fechaFin: {
      type: Date,
      required: true,
    },
    viaSuministro: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true, // Guarda las fechas de creación y actualización
  }
);

export default model('Medicamento', medicamentoSchema);
