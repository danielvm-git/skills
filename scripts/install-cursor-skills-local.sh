#!/usr/bin/env bash
# Install skills into a project: <install-root>/.cursor/skills (not ~/.cursor/skills).
# Usage: ./scripts/install-cursor-skills-local.sh [INSTALL_ROOT]
#   INSTALL_ROOT defaults to the current working directory. Skills are read from
#   this skills repository unless SOURCE_DIR is set.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INSTALL_ROOT="$(cd "${1:-"$PWD"}" && pwd)"
export TARGET_DIR="${TARGET_DIR:-"$INSTALL_ROOT/.cursor/skills"}"
export SOURCE_DIR="${SOURCE_DIR:-$REPO_ROOT}"

exec "$REPO_ROOT/scripts/install-cursor-skills.sh"
