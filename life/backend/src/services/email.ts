import nodemailer from 'nodemailer';
import { config } from '../config/config';
import dotenv from 'dotenv';

dotenv.config();
// Configuración del transporte
const transporte = nodemailer.createTransport({
  host: config.email_host,
  port: Number(config.email_port),
  secure: false, 
  auth: {
    user: config.email_user,
    pass: config.email_pass,
  },
});

// Función para enviar el correo
export const enviarCorreo = async (to: string, subject: string, html: string) => {
   try { 
  const info = await transporte.sendMail({
    from: `"Life Reminder" <${config.email_user}>`,
    to,
    subject,
    html,
  });
  console.log("Correo enviado:", info.messageId);
} catch (er) {
    console.error("Error al enviar el correo", er);
    throw new Error("ne se pudo enviar el correo")
}
};
