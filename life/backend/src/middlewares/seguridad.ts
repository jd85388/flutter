import jwt from 'jsonwebtoken';
import {Request, Response, NextFunction} from 'express';

const codificado = process.env.jwt_codificado;

export const verificarToken = (
    req: Request, res: Response, next: NextFunction) => {
    const token = req.headers['authorization'];

    if (!token) return res.status(403).json({
        message:"Token no encontrado"
    });

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