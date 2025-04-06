import { Schema, model, Document } from 'mongoose';
import bcrypt from 'bcryptjs';
import dotenv from 'dotenv';
dotenv.config();

const JWT_SECRET = process.env.JWT_SECRET as string;

interface IUsuario extends Document {
  nombre: string;
  correo: string;
  telefono: number;
  genero?: string;
  password: string;
}

const usuarioSchema = new Schema<IUsuario>({
  nombre: { type: String, required: true },
  correo: { 
    type: String, 
    required: true, 
    unique: true, // Garantiza que el correo sea único
    validate: {
      validator: function(value: string) {
        // Expresión regular para validar el formato del correo
        const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return regex.test(value);
      },
      message: 'Correo electrónico inválido', // Mensaje en caso de error de validación
    }
  },
  telefono: { type: Number, required: true },
  genero: { type: String, required: false },
  password: { type: String, required: true, select: false }
}, {
  timestamps: true
});

// Hashear la contraseña antes de guardar
usuarioSchema.pre<IUsuario>('save', async function (next) {
  if (!this.isModified('password')) return next();
  this.password = await bcrypt.hash(this.password, 10);
  next();
});

export default model<IUsuario>('Usuario', usuarioSchema);
