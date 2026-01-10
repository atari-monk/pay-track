export interface CreateUserDto {
  name: string;
  email: string;
}

export function validateCreateUserDto(body: any): CreateUserDto {
  if (!body?.name || typeof body.name !== 'string') {
    throw new Error('Invalid name');
  }

  if (!body?.email || typeof body.email !== 'string') {
    throw new Error('Invalid email');
  }

  return {
    name: body.name.trim(),
    email: body.email.trim().toLowerCase()
  };
}
