# Production-Ready Next.js + PostgreSQL + AWS Demo

Public, client-safe engineering demo for production practices.

## Demonstrates
- Next.js App Router + TypeScript
- PostgreSQL migration and multi-tenant RLS
- explicit human approval before writes
- Docker reproducibility
- database, API and browser smoke checks
- CI build/type/test gates
- backup/restore procedure
- AWS RDS / IAM / Secrets Manager / CloudWatch blueprint

## Local run
1. Copy .env.example to .env.local
2. npm install
3. npm run db:up
4. npm run db:test
5. npm run typecheck
6. npm test
7. npm run build
8. npm run smoke

## API
GET /api/health

GET /api/records with header x-demo-tenant.

POST /api/records requires the tenant header and body:
{"title":"approved record","approved":true}

A write without approved=true fails closed.

## Safety
No proprietary C12 or AI Manufaktura code is included. No secrets are committed.

See docs/AWS.md and docs/BACKUP_RESTORE.md.

## Live walkthrough
Explain RLS and tenant context, run DB isolation tests, show the approval gate, run typecheck/tests/build/smoke, then explain the AWS blueprint and recovery choices.

Scope note: this proves personally reviewable code and production-oriented patterns. It does not claim paid production AWS operation beyond what is implemented and documented here.
