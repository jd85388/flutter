import Tratamiento from '../models/Tratamiento';

interface TratamientoData {
  usuarioId: string;
  nombre: string;
  descripcion: string;
  duracion: number;  // Duración en días
}

export const registrarTratamiento = async (datos: TratamientoData) => {
  const { usuarioId, nombre, descripcion, duracion } = datos;

  const nuevoTratamiento = new Tratamiento({
    usuarioId,
    nombre,
    descripcion,
    duracion,
  });

  try {
    const tratamientoGuardado = await nuevoTratamiento.save();
    return tratamientoGuardado;
  } catch (error) {
    throw new Error('Error al guardar el tratamiento: ');
  }
};
