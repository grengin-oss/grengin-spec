# Changelog

All notable changes to the Grengin API specification will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.1] - 2025-12-17

### Added

- User status endpoint (`PATCH /admin/users/{user_id}/status`)
- Departments list endpoint (`GET /admin/departments`)

### Changed

- `GET /models` now requires authentication (was previously public)

## [1.1.0] - 2025-12-11

> **Migration Guide:** [v1.0 to v1.1](docs/migrations/v1.0-to-v1.1.md)

### Added

- AI engine management endpoints replacing API key CRUD
- Engine validation endpoint (`POST /admin/ai-engines/{id}/validate`)
- Model discovery endpoint (`GET /admin/ai-engines/{id}/models`)
- Model whitelisting and per-user model access controls
- `AIEngine`, `AIModel`, `AIModelParameter` schemas
- Chat model config and usage tracking in responses
- `POST` handler for OAuth callback (Azure AD long codes)
- Dedicated onboarding endpoints file

### Changed

- Migrated to OpenAPI 3.1+ nullable style (type arrays)

### Removed

- `/admin/api-keys` endpoints (replaced by `/admin/ai-engines`)

## [1.0.0] - 2025-11-25

### Added

- Initial API specification
- Authentication endpoints (login, SSO, logout)
- Chat endpoints with streaming support
- User management and admin endpoints
- Analytics and audit logging
- File upload and management
- Health check endpoint
