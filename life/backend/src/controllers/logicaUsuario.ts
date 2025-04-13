import Usuario from '../models/Usuario';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import {Request, Response} from 'express';
import { config } from '../config/config';
import { enviarCorreo  } from '../services/email';

const codificado = config.jwt_codificado;

export const registre = async (req: Request, res: Response) => {
    const {name, surname, telephone, email, age, password} = req.body;
    
    if (!name || !surname || !telephone ||!email || !age || !password) {
        return res.status(400).json({message:"son obligatorios todos los campos"});
    }

    if (typeof email !== 'string' || !email.includes('@')) {
        return res.status(400).json({ message:"Email no valido"});
    }

    try{
        const existe = await Usuario.findOne({email});
        if (existe) return res.status(400).json({
            message: "Usuario registrado"
        });

        const hashedPassword = await bcrypt.hash(password, 12);
        const newUsuario = new Usuario({
            name,
            surname,
            telephone,
            email,
            age,  
            password: hashedPassword,
            rol: 'normal'
        });
        await newUsuario.save();
    


        await enviarCorreo(
            email,
             "Bienvenido a Life Reminder",
            `<h2>hola ${name},</h2><br><p>Nos alegra mucho que te hayas registrado en Life Reminder
            nosotros cuidaremos de ti, te recordaremos los tiempo exaptos para cumplir con tu citas medicas,
            tomar tu medicamento ademas siempre te aconsejaremos lo mejor para motivarte a cuidar mas de ti</p>`
         );

        res.status(201).json({
            message:"Felicidades te has registrado, te hemos enviado un mensaje a tu correo"
        });
    } catch (error){
         if ((error as any).code === 11000) {
            return res.status(400).json({
               message:"El correo o telefono ya se encuentran registrados"
           });
        }

        return res.status(500).json({
            message:"Error en el servidor", error
        });
    }
};

export  const login = async (req: Request, res: Response) => {
    const {email, password} = req.body;

    try {
        const pepe = await Usuario.findOne({email});
        if(!pepe) return res.status(404).json({
            message:"El usuario no esta registrado"
        });

        const equivocado = await bcrypt.compare(password, pepe.password);
        if (!equivocado) return res.status(401).json({
            message:" Contraseña incorrecta, vuelve a intentar"
        });

        const token = jwt.sign({
            id: pepe._id
        },codificado);


        res.json({
            token
        });
    } catch (e) {
        console.error("Error en login:", e); 
        res.status(500).json({
            message: "Perdimos la conexion con el servidor",
            error: e instanceof Error ? e.message : e
        });
    }
    
    }

