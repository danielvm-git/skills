#!/usr/bin/env bash
# add-model-frontmatter.sh — one-time helper; idempotent model: injection
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

declare -A MODELS=(
  [using-bigpowers]=sonnet
  [orchestrate-project]=sonnet
  [survey-context]=haiku
  [research-first]=sonnet
  [elaborate-spec]=opus
  [map-codebase]=sonnet
  [model-domain]=sonnet
  [define-language]=sonnet
  [grill-me]=sonnet
  [grill-with-docs]=opus
  [deepen-architecture]=sonnet
  [design-interface]=opus
  [assess-impact]=sonnet
  [change-request]=sonnet
  [scope-work]=sonnet
  [slice-tasks]=sonnet
  [define-success]=sonnet
  [plan-work]=opus
  [plan-refactor]=sonnet
  [plan-release]=sonnet
  [spike-prototype]=sonnet
  [kickoff-branch]=haiku
  [guard-git]=haiku
  [hook-commits]=haiku
  [seed-conventions]=sonnet
  [develop-tdd]=sonnet
  [enforce-first]=haiku
  [delegate-task]=sonnet
  [dispatch-agents]=sonnet
  [execute-plan]=haiku
  [wire-observability]=sonnet
  [verify-work]=haiku
  [run-evals]=sonnet
  [investigate-bug]=sonnet
  [diagnose-root]=sonnet
  [validate-fix]=haiku
  [audit-code]=haiku
  [request-review]=opus
  [respond-review]=sonnet
  [trace-requirement]=haiku
  [commit-message]=haiku
  [release-branch]=haiku
  [inspect-quality]=sonnet
  [organize-workspace]=haiku
  [stocktake-skills]=sonnet
  [evolve-skill]=opus
  [terse-mode]=haiku
  [craft-skill]=sonnet
  [edit-document]=sonnet
  [session-state]=haiku
  [migrate-spec]=sonnet
  [visual-dashboard]=sonnet
  [write-document]=sonnet
  [setup-environment]=haiku
  [reset-baseline]=haiku
  [search-skills]=haiku
  [compose-workflow]=sonnet
  [simulate-agents]=sonnet
)

for skill_dir in "$REPO_ROOT"/*/; do
  skill_md="$skill_dir/SKILL.md"
  [[ -f "$skill_md" ]] || continue
  name=$(basename "$skill_dir")
  model="${MODELS[$name]:-sonnet}"
  if grep -q '^model:' "$skill_md" 2>/dev/null; then
    continue
  fi
  # Insert model: after name: line in frontmatter
  awk -v m="$model" '
    /^---$/ { fm++; print; next }
    fm==1 && /^name:/ { print; print "model: " m; next }
    { print }
  ' "$skill_md" > "$skill_md.tmp" && mv "$skill_md.tmp" "$skill_md"
  echo "model: $model → $name"
done
