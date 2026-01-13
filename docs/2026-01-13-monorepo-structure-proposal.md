Below is a **clean, minimal monorepo proposal** aligned with your story + architecture, using **pnpm**, **TypeScript (latest)**, and **microservice-ready structure**.

This answer **only includes must-have config files** for:

* the **monorepo**
* the **UserService**

So you can immediately start implementing the service logic next.

---

## 1. Proposed Monorepo Structure

```text
pay-track/
├── package.json              # root (workspace + scripts)
├── pnpm-workspace.yaml       # pnpm monorepo definition
├── tsconfig.base.json        # shared TypeScript config
├── .gitignore
├── services/
│   └── user-service/
│       ├── package.json
│       ├── tsconfig.json
│       ├── src/
│       │   └── index.ts      # service entrypoint (placeholder)
│       └── test/
│           └── user.test.ts  # placeholder for Jest
└── docs/
    └── story-architecture.md
```

Notes:

* `services/*` = independent deployable microservices
* shared config lives at root
* no premature abstractions yet (no shared libs folder)

---

## 2. Root Monorepo Configuration (Must-Have)

### `pnpm-workspace.yaml`

```yaml
packages:
  - "services/*"
```

---

### Root `package.json`

```json
{
  "name": "pay-track",
  "private": true,
  "type": "module",
  "packageManager": "pnpm@10.28.0",
  "main": "dist/index.js",
  "scripts": {
    "build": "pnpm -r build",
    "dev": "pnpm -r dev",
    "test": "pnpm -r test"
  },
  "devDependencies": {
    "typescript": "latest"
  }
}
```

Why:

* `-r` (recursive) keeps microservices independent
* no global frameworks installed yet

---

### Root `tsconfig.base.json`

Shared **strict** defaults for all services.

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "lib": ["ES2022"],
    "strict": true,
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "outDir": "dist",
    "declaration": true,
    "sourceMap": true
  },
  "include": ["src/**/*.ts"],
  "exclude": ["node_modules", "dist"]
}
```

---

### Root `.gitignore`

```gitignore
node_modules
dist
.env
.env.*
```

### .npmrc

```plaintext
node-linker=hoisted
```

---

## 3. UserService – Must-Have Setup

### `services/user-service/package.json`

```json
{
  "name": "@pay-track/user-service",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "ts-node-dev --respawn src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js",
    "test": "jest"
  },
  "dependencies": {
    "express": "^4.19.2",
    "jsonwebtoken": "^9.0.2",
    "sequelize": "^6.37.1",
    "sqlite3": "^5.1.7"
  },
  "devDependencies": {
    "@types/express": "^4.17.21",
    "@types/jest": "^29.5.11",
    "@types/jsonwebtoken": "^9.0.5",
    "jest": "^29.7.0",
    "ts-jest": "^29.1.1",
    "ts-node-dev": "^2.0.0",
    "typescript": "^5.3.3"
  }
}
```

Why SQLite:

* zero-config for portfolio
* easy later swap to Postgres/MySQL

---

### `services/user-service/tsconfig.json`

```json
{
  "extends": "../../tsconfig.base.json",
  "compilerOptions": {
    "rootDir": "src"
  },
  "include": ["src"]
}
```

---

### `services/user-service/tsconfig.test.json`

```json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "rootDir": ".",
    "outDir": "dist-test",
    "types": ["jest", "node"]
  },
  "include": ["test/**/*.ts"]
}
```

---

### `services/user-service/src/index.ts` (placeholder)

```ts
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
```

---

### `services/user-service/test/user.test.ts` (placeholder)

```ts
describe("UserService bootstrap", () => {
  it("should pass placeholder test", () => {
    expect(true).toBe(true);
  });
});
```

---

## 4. Why This Is a Strong Portfolio Foundation

✔ Clear microservice boundaries
✔ Modern Node.js + TypeScript
✔ pnpm monorepo (industry standard)
✔ Ready for:

* JWT auth
* Sequelize models
* Jest tests
* Docker & CI later

---

### Next logical steps (when you’re ready):

1. User entity + Sequelize setup
2. Auth flow (register/login + JWT)
3. Service-to-service auth pattern
4. Add CardService with same template

If you want, next I can:

* scaffold **UserService auth + models**
* design **API contracts**
* add **Docker + CI**
* or enforce **hexagonal / clean architecture**
