import { Router } from 'express';
import { User } from '../models/User';
import { validateCreateUserDto } from '../dto/CreateUserDto';

const router = Router();

router.post('/users', async (req, res) => {
  try {
    const dto = validateCreateUserDto(req.body);
    const user = await User.create(dto);
    res.status(201).json(user);
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
});

router.get('/users/:id', async (req, res) => {
  const user = await User.findByPk(req.params.id);
  if (!user) {
    return res.status(404).json({ error: 'User not found' });
  }
  res.json(user);
});

export default router;
