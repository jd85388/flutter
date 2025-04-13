import { Request, Response } from 'express';
import { registrarTratamiento } from '../services/servicioTratamiento';

export const registrarTratamientoController = async (req: Request, res: Response) => {
  const { usuarioId, nombre, descripcion, duracion } = req.body;

  if (!usuarioId || !nombre || !descripcion || !duracion) {
    return res.status(400).json({ message: 'Todos los campos son obligatorios' });
  }

  try {
    const tratamiento = await registrarTratamiento({
      usuarioId,
      nombre,
      descripcion,
      duracion,
    });

    res.status(201).json(tratamiento);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error al registrar el tratamiento' });
  }
};
