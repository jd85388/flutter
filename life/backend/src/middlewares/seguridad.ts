import jwt from 'jsonwebtoken';
import { Request, Response, NextFunction } from 'express';
import { config } from '../config/config';

const codificado = config.jwt_codificado;

export const verificarToken = (
    req: Request,
    res: Response,
    next: NextFunction
): void => {
    const autorizacion = req.headers['authorization'];

    if (!autorizacion) {
        res.status(403).json({
            message: "No se encontró el token, intenta otra vez",
        });
        return; 
    }

    const token = autorizacion.startsWith('Bearer ')
        ? autorizacion.slice(7).trim()
        : autorizacion;

    try {
        const decoded = jwt.verify(token, codificado!);
        (req as any).user = decoded;
        next(); 
    } catch (e) {
        res.status(401).json({
            message: "Token incorrecto",
            error: e,
        });
        return; 
    }
};
