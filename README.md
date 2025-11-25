# Grengin API Specification

[![OpenAPI 3.2](https://img.shields.io/badge/OpenAPI-3.2-green.svg)](https://spec.openapis.org/oas/v3.2.0)
[![Validation](https://github.com/grengin/api/actions/workflows/validate.yml/badge.svg)](https://github.com/grengin/api/actions)

The canonical API contract for Grengin, an enterprise-grade AI chat platform. This specification serves as the single source of truth shared between frontend and backend implementations.

## Overview

Grengin provides organizations with a secure, self-hosted AI chat interface supporting multiple LLM providers (OpenAI, Anthropic, Groq). Key capabilities include:

- **Multi-provider AI chat** with streaming responses
- **Enterprise SSO** via OpenID Connect
- **Usage analytics** and cost tracking per user/department
- **Admin controls** for rate limits, budgets, and audit logging
- **File attachments** for context-aware conversations

## Quick Start

### Installation

```bash
# Add as a git submodule
git submodule add https://github.com/grengin/api.git api
git submodule update --init --recursive
```

### Generate Types

```bash
# TypeScript (using openapi-typescript)
npx openapi-typescript api/dist/openapi.yaml -o src/types/api.ts

# Or bundle first if working with source files
cd api && ./scripts/bundle.sh
```

### Validate

```bash
cd api
./scripts/validate.sh
```

## Project Structure

```
├── openapi.yaml              # Main specification (entry point)
├── paths/                    # Endpoint definitions by domain
│   ├── admin.yaml            # Organization & user management
│   ├── analytics.yaml        # Usage metrics & audit logs
│   ├── auth.yaml             # Authentication & onboarding
│   ├── chat.yaml             # Conversations & streaming
│   ├── common.yaml           # Health, models, files, settings
│   └── user.yaml             # Current user endpoints
├── schemas/                  # Data type definitions by domain
│   ├── admin.yaml            # Admin-related schemas
│   ├── analytics.yaml        # Analytics & audit schemas
│   ├── auth.yaml             # Auth & session schemas
│   ├── chat.yaml             # Chat & message schemas
│   ├── common.yaml           # Shared schemas (errors, files)
│   └── user.yaml             # User & role schemas
├── scripts/
│   ├── bundle.sh             # Bundle to single file
│   └── validate.sh           # Run linting & validation
└── dist/                     # Bundled output (generated)
```

## API Reference

### Authentication

Most endpoints require a Bearer token:

```
Authorization: Bearer <jwt_token>
```

Tokens are obtained via password login (`POST /auth/login`) or SSO (`GET /auth/{provider}`).

### Core Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/health` | GET | Service health check |
| `/me` | GET | Current user profile |
| `/chat` | GET | List conversations |
| `/chat/stream` | POST | Stream AI response (SSE) |
| `/chat/{id}` | GET/PUT/DELETE | Manage conversation |
| `/files` | GET/POST | List/upload files |
| `/settings` | GET/PUT | User preferences |
| `/models` | GET | Available AI models |

### Admin Endpoints

Requires admin role. Prefixed with `/admin/`.

| Endpoint | Description |
|----------|-------------|
| `/admin/users` | User management |
| `/admin/organization` | Organization settings |
| `/admin/api-keys` | LLM provider API keys |
| `/admin/sso-providers` | OIDC configuration |
| `/admin/rate-limits` | Rate limit policies |
| `/admin/budgets` | Spending controls |

### Analytics & Audit

Requires admin role.

| Endpoint | Description |
|----------|-------------|
| `/analytics/costs` | Cost breakdown by user/model |
| `/analytics/usage` | Usage statistics |
| `/analytics/trends` | Historical trends |
| `/audit/logs` | Security audit trail |

## Documentation

View the interactive API documentation using one of these methods:

```bash
# Swagger UI (with "Try it out" functionality)
docker run -p 8080:8080 -e SWAGGER_JSON=/api/dist/openapi.yaml \
  -v $(pwd):/api swaggerapi/swagger-ui

# Redocly (clean reference docs)
npx @redocly/cli preview-docs dist/openapi.yaml
```

Then open http://localhost:8080 in your browser.

## Development

### Making Changes

1. Edit the relevant file in `paths/` or `schemas/`
2. Run validation: `./scripts/validate.sh`
3. Commit and push changes
4. Update submodule in dependent projects:

```bash
git submodule update --remote api
git add api
git commit -m "chore: update API contract"
```

### Validation Tools

- **[Spectral](https://stoplight.io/spectral)** — API style enforcement
- **[Redocly CLI](https://redocly.com/docs/cli/)** — OpenAPI validation & bundling

Both run automatically via GitHub Actions on pull requests.

### Bundling

The specification uses `$ref` for maintainability. Generate a single resolved file:

```bash
./scripts/bundle.sh
# Output: dist/openapi.yaml
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/add-endpoint`)
3. Make your changes and validate
4. Submit a pull request

Please ensure all validation checks pass before submitting.

## License

Licensed under the **Grengin Sustainable Use License (SUL)**.

**Free for:**
- Individuals and non-profits
- Organizations under $5M USD annual revenue
- Non-commercial and educational use

**Commercial license required** for organizations with $5M+ revenue using Grengin commercially.

See [LICENSE.md](LICENSE.md) for details or visit [grengin.com/pricing](https://grengin.com/pricing) for commercial licensing.
