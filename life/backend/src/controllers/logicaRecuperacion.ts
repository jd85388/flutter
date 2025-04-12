import {Request, Response} from 'express';
import Usuario from '../models/Usuario';
import jwt from 'jsonwebtoken';
import { config } from '../config/config';
import { enviarCorreo } from '../services/email';
import bcrypt from 'bcryptjs';

export const recuperacionCuenta = async (req: Request, res: Response) => {
    try {
        const { correo } = req.body;

        const usuario = await Usuario.findOne({ email : correo});
        if (!usuario) {
            return res.status(404).json({message: "el correo no esta registrado"});
        }

        const token = jwt.sign({id: usuario._id}, config.jwt_codificado, {expiresIn: "30m"});

        const enlace = `${config.backend_host}/api/recuperar/${token}`;
        const html = `
        <h2>Recuperacion de cuenta</h2>
        <p>Lamentamos lo ocurrido, haz click en el siguiente enlace para cambiar tu contraeña</p>
        <a href="${enlace}">${enlace}</a>
        `;

        await enviarCorreo(correo,"Recuperar tu cuenta - Life Remider", html);
        res.json({message: "correo de recuperacion enviado"});
    } catch (err){
        console.error(err);
        res.status(500).json({message:"No pudimos recuperar tu cuenta, vuelve a intentar"});
    }
};

export const cambiarPassword = async (req: Request, res: Response) => {
    try{

        const { token, nuevaPassword } = req.body;

        const datos = jwt.verify(token, config.jwt_codificado) as {id: string};
 
        const usuario = await Usuario.findById(datos.id);
        
        if(!usuario) {
           return res.status(404).json({message:"Este usuario no esta registrado"});
        }

        const passwordEncriptada = await bcrypt.hash(nuevaPassword, 10);
        usuario.password =passwordEncriptada;
        await usuario.save();

        res.json({message: "cambio de contraseña exitoso"});
    } catch (e) {
        console.error(e);
        res.status(400).json({message:"tokem incorrecto o expirado"});
    
    }
}





