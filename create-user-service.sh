#!/bin/bash
# create-user-service.sh
# Deterministic generator – ALWAYS overwrite
# PayTrack / user-service

set -e

SERVICE_NAME="user-service"

echo "🔁 Regenerating ${SERVICE_NAME}"

rm -rf ${SERVICE_NAME}
mkdir -p ${SERVICE_NAME}
cd ${SERVICE_NAME}

# ----------------------
# package.json
# ----------------------
cat <<'EOF' > package.json
{
  "name": "user-service",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "build": "tsc",
    "start": "ts-node src/index.ts"
  }
}
EOF

# ----------------------
# install deps
# ----------------------
pnpm add express sequelize sequelize-typescript pg pg-hstore reflect-metadata dotenv uuid
pnpm add -D typescript ts-node @types/node

# ----------------------
# tsconfig.json
# ----------------------
cat <<'EOF' > tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "outDir": "dist",
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true
  },
  "include": ["src/**/*"]
}
EOF

# ----------------------
# .gitignore
# ----------------------
cat <<'EOF' > .gitignore
node_modules
dist
.env
EOF

# ----------------------
# env example
# ----------------------
cat <<'EOF' > .env.example
DB_HOST=localhost
DB_PORT=5432
DB_USER=paytrack
DB_PASSWORD=paytrack
DB_NAME=paytrack_users
EOF

# ----------------------
# docker-compose
# ----------------------
cat <<'EOF' > docker-compose.yml
services:
  postgres:
    image: postgres:15
    container_name: paytrack-user-db
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: paytrack
      POSTGRES_PASSWORD: paytrack
      POSTGRES_DB: paytrack_users
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
EOF

# ----------------------
# src structure
# ----------------------
mkdir -p src/models

# ----------------------
# User model
# ----------------------
cat <<'EOF' > src/models/User.ts
import {
  Table,
  Column,
  Model,
  PrimaryKey,
  Default,
  DataType
} from 'sequelize-typescript';
import { v4 as uuidv4 } from 'uuid';

@Table({
  tableName: 'users',
  timestamps: true
})
export class User extends Model {
  @PrimaryKey
  @Default(uuidv4)
  @Column(DataType.UUID)
  id!: string;

  @Column(DataType.STRING)
  name!: string;

  @Column(DataType.STRING)
  email!: string;
}
EOF

# ----------------------
# index.ts (DB bootstrap only)
# ----------------------
cat <<'EOF' > src/index.ts
import 'reflect-metadata';
import { Sequelize } from 'sequelize-typescript';
import dotenv from 'dotenv';
import { User } from './models/User';

dotenv.config();

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

(async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Database connected');
  } catch (error) {
    console.error('❌ Database connection failed');
    console.error(error);
    process.exit(1);
  }
})();
EOF

echo "✅ user-service regenerated"
