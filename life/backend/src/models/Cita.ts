import mongoose from 'mongoose';

const citaSchema = new mongoose.Schema({
  nombre: { type: String, required: true },
  tipoConsulta: { type: String, required: true },
  motivo: { type: String, required: true },
  fecha: { type: String, required: true },
  hora: { type: String, required: true },
  descripcion: { type: String },
});

export default mongoose.model('Cita', citaSchema);
