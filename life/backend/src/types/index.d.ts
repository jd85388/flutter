// backend/types/express/index.d.ts
/**declare namespace Express {
    export interface Request {
      user?: {
        id: string;
        email: string;
      };
    }
  }**/
    import { JwtPayload } from 'jsonwebtoken';

    declare module 'express-serve-static-core' {
      interface Request {
        user?: any; // o lo que sea que guardes en el token
      }
    }
    