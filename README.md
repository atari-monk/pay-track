- Prompt do generowania skryptu create-user-service.sh

W terminalu PowerShell (wtyczka)

```sh
cd ./script
./create-user-service.ps1
```

- Inkrementowalny deving user-service przez skrypt oraz komendy testujące

```sh
chmod +x create-user-service.sh
./create-user-service.sh
cd user-service
cp .env.example .env
docker compose up -d
pnpm build
pnpm migrate
pnpm start
```
