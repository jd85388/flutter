import { Router } from 'express';
import { register, login, profile } from '../controlador/auth';
import { verifyToken } from '../utils/authMiddleware'; // <- Esta es la línea correcta
const router = Router();

router.post('/register', register);
router.post('/login', login);
router.get('/profile', verifyToken, profile); // Esta es ruta protegida con token

export default router;
