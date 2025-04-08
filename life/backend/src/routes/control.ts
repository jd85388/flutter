import express from 'express';
import {Request, Response, NextFunction} from 'express';
import { verificarToken } from '../middlewares/seguridad';
import { registre, login } from '../controllers/logicaUsuario';

const router = express.Router();

const manejarAsync = (fn: any) => {
    return (req: Request, res: Response, next: NextFunction) => {
        Promise.resolve(fn(req, res, next)).catch(next);
    };
};

router.post('/registro', manejarAsync(registre));
router.post('/inicio', manejarAsync(login));

router.get('/profile', manejarAsync(verificarToken), (req: Request, res: Response) => {
    res.json({
        message:"Bienvenido a Life reminder",
         user: req.user
    });
});

export default router;