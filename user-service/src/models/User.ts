import {
  Table,
  Column,
  Model,
  PrimaryKey,
  Default,
  DataType
} from 'sequelize-typescript';
import { v4 as uuidv4 } from 'uuid';

/**
 * DB attributes
 */
export interface UserAttributes {
  id: string;
  name: string;
  email: string;
}

/**
 * Attributes required on creation
 */
export interface UserCreationAttributes {
  name: string;
  email: string;
}

@Table({
  tableName: 'users',
  timestamps: true
})
export class User extends Model<UserAttributes, UserCreationAttributes> {
  @PrimaryKey
  @Default(uuidv4)
  @Column(DataType.UUID)
  id!: string;

  @Column(DataType.STRING)
  name!: string;

  @Column(DataType.STRING)
  email!: string;
}
