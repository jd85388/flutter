import express from 'express';
import { Request, Response, NextFunction } from 'express';  
import { verificarToken } from '../middlewares/seguridad';
import { registre, login } from '../controllers/logicaUsuario';
import dotenv from 'dotenv';
import { recuperacionCuenta, cambiarPassword } from '../controllers/logicaRecuperacion';
import { registrarMedicamentoController } from '../controllers/logicaDeMedicamento';
import { registrarCitaController } from '../controllers/logicaCita'; // Añadir ruta de citas
import { registrarTratamientoController } from '../controllers/logicaDeTratamiento'; 

dotenv.config();

const router = express.Router();

const manejarAsync = (fn: any) => {
    return (req: Request, res: Response, next: NextFunction) => {
        Promise.resolve(fn(req, res, next)).catch(next);
    };
};

router.post('/cambioContraseña', manejarAsync(cambiarPassword));
router.post('/recuperacion', manejarAsync(recuperacionCuenta));
router.post('/registro', manejarAsync(registre));
router.post('/inicio', manejarAsync(login));
router.post('/registrarMedicamento', manejarAsync(registrarMedicamentoController));
router.post('/registrarCita', manejarAsync(registrarCitaController)); // Ruta de cita
router.post('/registrarTratamiento', manejarAsync(registrarTratamientoController)); // Ruta de tratamiento

router.get('/profile', manejarAsync(verificarToken), (req: Request, res: Response) => {
    res.json({
        message: "Bienvenido a Life reminder",
        user: (req as any).user
    });
});

export default router;
