import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { conectarM } from './conexion';
import authRoutes from './routers/authRouter';
import medicamentoRoutes from './routers/medicamentoRouter';

dotenv.config(); // Cargar variables de entorno

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors()); // Habilita CORS
app.use(express.json()); // Parsear JSON

// Conectar a la base de datos
conectarM();

// Rutas
app.use('/auth', authRoutes);
app.use('/medicamentos', medicamentoRoutes);

// Ruta base opcional
app.get('/', (req, res) => {
  res.send('API de LifeReminder funcionando ✅');
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`✅ Servidor corriendo en http://localhost:${PORT}`);
});
