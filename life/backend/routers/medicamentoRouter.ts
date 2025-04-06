// backend/routers/medicamentoRouter.ts

import { Router } from 'express';
import {
  crearMedicamento,
  obtenerMedicamentos,
  obtenerMedicamentoPorId,
  actualizarMedicamento,
  eliminarMedicamento
} from '../controlador/medicamentoControl';
import { verifyToken } from '../utils/authMiddleware';

const router = Router();

// Rutas de medicamentos
router.post('/', verifyToken, crearMedicamento); // Proteger si solo usuarios autenticados deben crear
router.get('/', obtenerMedicamentos);
router.get('/:id', obtenerMedicamentoPorId);
router.put('/:id', verifyToken, actualizarMedicamento); // Proteger si quieres que solo usuarios con token actualicen
router.delete('/:id', verifyToken, eliminarMedicamento); // Igual para eliminar

export default router;
