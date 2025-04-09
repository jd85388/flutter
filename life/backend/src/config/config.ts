import dotenv from 'dotenv';

dotenv.config();

export const config = {
    PORT: process.env.PORT || 3000,
    Conexion: process.env.Conexion || "mongodb://localhost:27017/tuDB",
    jwt_codificado: process.env.jwt_codificado || "clavePorDefecto"
};