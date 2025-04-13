import { Request, Response } from 'express';
import { registrarMedicamento } from '../services/servicioMedicamento';

export const registrarMedicamentoController = async (req: Request, res: Response) => {
  const { usuarioId, nombre, dosis, frecuencia, fechaFin, viaSuministro } = req.body;

  if (!usuarioId || !nombre || !dosis || !frecuencia || !fechaFin || !viaSuministro) {
    return res.status(400).json({ message: 'Todos los campos son obligatorios' });
  }

  try {
    const medicamento = await registrarMedicamento({
      usuarioId,
      nombre,
      dosis,
      frecuencia,
      fechaFin,
      viaSuministro,
    });

    res.status(201).json(medicamento);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error al registrar el medicamento' });
  }
};
