const uri = 'mongodb+srv://jd8538879:Osorio10@baselife.khom87q.mongodb.net/?retryWrites=true&w=majority&appName=baseLife';

import mongoose from 'mongoose';


 export async function conectarM() {
  try {
    await mongoose.connect(uri);
    console.log("Conexión exitosa con la base de datos Life Reminder");
  } catch (e) {
    console.error("Conexión fallida:", e);
  }
}


