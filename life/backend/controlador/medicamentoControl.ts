// backend/controlador/medicamentoControl.ts

import { Request, Response } from 'express';
import Medicamento from '../modelos/modeloM';

// Crear medicamento
export const crearMedicamento = async (req: Request, res: Response) => {
  try {
    const usuarioId = (req as any).user?.id; // Requiere que authMiddleware agregue user al request

    if (!usuarioId) {
      return res.status(401).json({ message: 'Usuario no autenticado.' });
    }

    const nuevoMedicamento = new Medicamento({ ...req.body, usuarioId });
    await nuevoMedicamento.save();

    res.status(201).json({ message: 'Medicamento creado.', medicamento: nuevoMedicamento });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error al crear medicamento.', error });
  }
};

// Obtener todos los medicamentos
export const obtenerMedicamentos = async (req: Request, res: Response) => {
  try {
    const medicamentos = await Medicamento.find({ usuarioId: (req as any).user?.id });
    res.status(200).json(medicamentos);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener medicamentos.', error });
  }
};

// Obtener medicamento por ID
export const obtenerMedicamentoPorId = async (req: Request, res: Response) => {
  try {
    const medicamento = await Medicamento.findById(req.params.id);
    if (!medicamento) {
      return res.status(404).json({ message: 'Medicamento no encontrado.' });
    }
    res.status(200).json(medicamento);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener el medicamento.', error });
  }
};

// Actualizar medicamento
export const actualizarMedicamento = async (req: Request, res: Response) => {
  try {
    const medicamentoActualizado = await Medicamento.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!medicamentoActualizado) {
      return res.status(404).json({ message: 'Medicamento no encontrado.' });
    }
    res.status(200).json({ message: 'Medicamento actualizado.', medicamento: medicamentoActualizado });
  } catch (error) {
    res.status(500).json({ message: 'Error al actualizar medicamento.', error });
  }
};

// Eliminar medicamento
export const eliminarMedicamento = async (req: Request, res: Response) => {
  try {
    const eliminado = await Medicamento.findByIdAndDelete(req.params.id);
    if (!eliminado) {
      return res.status(404).json({ message: 'Medicamento no encontrado.' });
    }
    res.status(200).json({ message: 'Medicamento eliminado.' });
  } catch (error) {
    res.status(500).json({ message: 'Error al eliminar medicamento.', error });
  }
};
