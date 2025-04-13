import dotenv from 'dotenv';

dotenv.config();

export const config = {
    PORT: process.env.PORT || 3000,
    Conexion: process.env.Conexion || "mongodb://localhost:27017/tuDB",
    jwt_codificado: process.env.jwt_codificado || "clavePorDefecto",
    email_host: process.env.EMAIL_HOST || '',
    email_port: process.env.EMAIL_PORT || '587',
    email_user: process.env.EMAIL_USER || '',
    email_pass: process.env.EMAIL_PASS || '',
    backend_host: process.env.BACKEND_HOST || 'http://localhost:3000',
    CODIGOROL: process.env.CODIGOROL || "ClaveSecretaParaCambiarRol",
    fronted_recuperacion: process.env.FRONTEND_RECUPERACION || "http://localhost:5173",
};