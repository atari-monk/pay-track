===== STORY =====

* Goal: a portfolio application simulating a global payments platform.
* MVP: UserService (users), CardService (card and transaction simulation), optionally BudgetService.
* Features: registration/login, adding cards, transaction simulation, basic budget management.
* Portfolio value: demonstration of skills in Node.js (latest LTS), microservices, automated testing, and APIs.

===== ARCHITECTURE =====

* Style: microservices, cloud-ready (simulated).
* Technologies: Node.js (latest LTS), Express, Sequelize, automated tests (e.g., Jest).
* MVP Services:

  1. UserService – CRUD + JWT
  2. CardService – card management, balances, simulated transactions
  3. BudgetService – budget creation, funds control (optional)
* Data: cards and budgets are linked to users; no real payment integrations.
