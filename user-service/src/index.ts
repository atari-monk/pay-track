import 'reflect-metadata';
import express from 'express';
import { Sequelize } from 'sequelize-typescript';
import dotenv from 'dotenv';
import { User } from './models/User';
import healthRouter from './routes/health';
import usersRouter from './routes/users';

dotenv.config();

const app = express();
app.use(express.json());
app.use(healthRouter);
app.use(usersRouter);

const sequelize = new Sequelize({
  dialect: 'postgres',
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  models: [User],
  logging: false
});

const PORT = Number(process.env.PORT) || 3000;

(async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Database connected');

    app.listen(PORT, () => {
      console.log(`🚀 User service listening on port ${PORT}`);
    });
  } catch (error) {
    console.error('❌ Startup failed');
    console.error(error);
    process.exit(1);
  }
})();
