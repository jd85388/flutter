import Medicamento from '../models/medicamento';

interface MedicamentoData {
  usuarioId: string;
  nombre: string;
  dosis: string;
  frecuencia: string;
  fechaFin: Date;
  viaSuministro: string;
}

export const registrarMedicamento = async (datos: MedicamentoData) => {
  const { usuarioId, nombre, dosis, frecuencia, fechaFin, viaSuministro } = datos;

  const newMedicamento = new Medicamento({
    usuarioId,
    nombre,
    dosis,
    frecuencia,
    fechaFin,
    viaSuministro,
  });

  try {
    const medicamentoGuardado = await newMedicamento.save();
    return medicamentoGuardado;
  } catch (error) {
    throw new Error('Error al guardar el medicamento');
  }
};
