#!/bin/bash
# Bundle multi-file OpenAPI spec into a single file
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Create dist directory if it doesn't exist
mkdir -p "$PROJECT_ROOT/dist"

# Bundle the spec (resolves all $ref to external files)
echo "Bundling OpenAPI specification..."
npx @redocly/cli bundle "$PROJECT_ROOT/openapi.yaml" -o "$PROJECT_ROOT/dist/openapi.yaml"

echo "Bundled spec written to dist/openapi.yaml"
echo ""
echo "You can now use dist/openapi.yaml as a single-file OpenAPI specification."
