import Cita from '../models/Cita';

interface CitaData {
  nombre: string;
  tipoConsulta: string;
  motivo: string;
  fecha: string;
  hora: string;
  descripcion?: string;
}

export const registrarCita = async (datos: CitaData) => {
  const { nombre, tipoConsulta, motivo, fecha, hora, descripcion } = datos;

  const nuevaCita = new Cita({
    nombre,
    tipoConsulta,
    motivo,
    fecha,
    hora,
    descripcion,
  });

  try {
    const citaGuardada = await nuevaCita.save();
    return citaGuardada;
  } catch (error) {
    throw new Error('Error al guardar la cita');
  }
};
