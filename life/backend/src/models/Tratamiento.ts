import mongoose from 'mongoose';

const tratamientoSchema = new mongoose.Schema({
  usuarioId: { type: mongoose.Schema.Types.ObjectId, ref: 'Usuario', required: true },
  nombre: { type: String, required: true },
  descripcion: { type: String, required: true },
  duracion: { type: String, required: true },
});

export default mongoose.model('Tratamiento', tratamientoSchema);
