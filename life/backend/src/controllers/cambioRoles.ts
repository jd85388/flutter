import { Request, Response } from 'express';
import Usuario from '../models/Usuario';
import { verificarToken } from '../middlewares/seguridad';
import { config } from '../config/config';


export const cambioRoles = async (req: Request, res: Response) => {
    const usuarioValido = (req as any).user;
    const { codigoSecreto } = req.body;
    const codigoValido = config.CODIGOROL;

    if (codigoSecreto !== codigoValido) {
        return res.status(400).json({
            message:"El codigo proporcionado es incorrecto"
        });
    }
    
    try {
        const usuario = await Usuario.findByIdAndUpdate(usuarioValido._id, {rol:"premium"}, {new: true});
        if (!usuario) {
            return res.status(404).json({
                message:"Usuario  no encontrado"
            });
        }

        res.json({
            message:"Felicidades, ahora eres tiene una cuenta en Life Reminer como usuario premium"
        });
    } catch (e) {
        console.error(e);
        res.status(500).json({
            message:"No pudimos cambiar el rol, contacta a soporte"
        });
    }
};