#!/bin/bash
# Validate OpenAPI specification
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Bundle first (resolves all $ref)
echo "Bundling OpenAPI specification..."
mkdir -p "$PROJECT_ROOT/dist"
npx @redocly/cli bundle "$PROJECT_ROOT/openapi.yaml" -o "$PROJECT_ROOT/dist/openapi.yaml" --config "$PROJECT_ROOT/.redocly.yaml"

echo ""
echo "Running Spectral linting on bundled spec..."
npx @stoplight/spectral-cli lint "$PROJECT_ROOT/dist/openapi.yaml" --ruleset "$PROJECT_ROOT/.spectral.yaml"

echo ""
echo "Running Redocly validation..."
npx @redocly/cli lint "$PROJECT_ROOT/openapi.yaml" --config "$PROJECT_ROOT/.redocly.yaml"

echo ""
echo "All validations passed!"
