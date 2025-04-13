import express from 'express';
import dotenv from 'dotenv';
import mongoose from 'mongoose';
import cors from 'cors';
import router from '../src/routes/control';


dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api', router);

const PORT = process.env.PORT || 10000;

mongoose.connect(process.env.CONEXION!)
.then(() => {
    console.log(
        "Conectando con la base de datos de Life reminder..."
    );
    app.listen(PORT, () => console.log(
        `Life Reminder esta en conectado en  http://localhost:${PORT}`
    ));
})
.catch(err => console.error(`No pudimos conectar`, err));