import mongoose from 'mongoose';

export const usuarioSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        unique: false,
    },
    surname: {
        type: String,
        required: true,
        unique: false
    },
    telephone: {
        type: String,
        required: true,
        unique: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        match: [/^\S+@\S+\.\S+$/, 'Email inválido'],
        trim: true
    },
    age: {
        type: Number,
        required: true,
        unique: false
    },
    password: {
        type: String,
        required: true,
        unique: false
    }
}, {timestamps: true

});

export default mongoose.model('Usuario', usuarioSchema);
