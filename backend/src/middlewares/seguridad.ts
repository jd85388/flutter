import jwt from 'jsonwebtoken';
import {Request, Response, NextFunction} from 'express';
import { config } from '../config/config';

const codificado = config.jwt_codificado;

export const verificarToken = (
    req: Request, res: Response, next: NextFunction) => {
    const autorizacion = req.headers['authorization'];

    if (!autorizacion) return res.status(403).json({
        message:"no se encontro el token, intenta otra vez"
    });

    const token = autorizacion.startsWith('Bearer ')
    ? autorizacion.slice(7).trim()
    : autorizacion;

    try {

        const decoded = jwt.verify(token, codificado!);

        (req as any).user = decoded
        
        next();

    } catch (e){
        res.status(401).json({
            message:"token incorrecto", error: e
        })
    }
};