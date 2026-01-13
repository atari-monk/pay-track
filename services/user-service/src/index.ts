import express from "express";

const app = express();
app.use(express.json());

app.get("/health", (_req, res) => {
  res.json({ status: "ok", service: "user-service" });
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`UserService running on port ${PORT}`);
});