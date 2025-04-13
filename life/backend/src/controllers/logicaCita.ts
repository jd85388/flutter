import { Request, Response } from 'express';
import { registrarCita } from '../services/servicioCita';

export const registrarCitaController = async (req: Request, res: Response) => {
  const { nombre, tipoConsulta, fecha, hora, descripcion, motivo } = req.body;

  // Verificar que todos los campos obligatorios estén presentes
  if (!nombre || !tipoConsulta || !fecha || !hora || !motivo) {
    return res.status(400).json({ message: 'Todos los campos obligatorios deben ser completados' });
  }

  try {
    const cita = await registrarCita({
      nombre,
      tipoConsulta,
      motivo,
      fecha,
      hora,
      descripcion    
    });
    res.status(201).json(cita);
  } catch (error) {
    console.error('Error al registrar la cita:', error);
    res.status(500).json({ message: 'Error al registrar la cita' });
  }
};
