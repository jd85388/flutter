// backend/controlador/usuarioControlador.ts
import dotenv from 'dotenv';
import { Request, Response } from 'express';
import modeloU from '../modelos/modeloU';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

dotenv.config();
const JWT_SECRET = process.env.JWT_SECRET!; // Lo ideal sería usar dotenv para cargar esto desde una variable de entorno

// Registrar usuario
export const register = async (req, res) => {
  try {
    const { nombre, email, password } = req.body;

    if (!nombre || !email || !password) {
      return res.status(400).json({ message: 'Faltan datos obligatorios.' });
    }

    const existingUser = await modeloU.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: 'El correo ya está registrado.' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = new modeloU({ nombre, email, password: hashedPassword });
    await newUser.save();

    res.status(201).json({ message: 'Usuario registrado con éxito.' });
  } catch (error) {
    res.status(500).json({ message: 'Error al registrar usuario.', error });
  }
};

// Login
export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: 'Correo y contraseña son requeridos.' });
    }

    const user = await modeloU.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado.' });
    }

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      return res.status(401).json({ message: 'Contraseña incorrecta.' });
    }

    const token = jwt.sign(
      { id: user._id, email: user.email },
      JWT_SECRET,
      { expiresIn: '1h' }
    );

    res.status(200).json({ message: 'Login exitoso.', token });
  } catch (error) {
    res.status(500).json({ message: 'Error al iniciar sesión.', error });
  }
};

// Perfil protegido
export const profile = async (req, res) => {
  try {
    const user = await modeloU.findById(req.user.id).select('-password');
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener el perfil.', error });
  }
};
