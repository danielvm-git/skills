#!/usr/bin/env bash
# install.sh — global symlink install for bigpowers skills
#
# Supported tools:
#   Claude Code  → ~/.claude/skills/<name>/ (one symlink per skill)
#   Gemini CLI   → ~/.gemini/extensions/bigpowers/ (one dir symlink)
#   Cursor       → ~/.cursor/rules/ (one dir symlink; per-project note printed)
#   OpenCode     → instructions printed (no standard global path)
#
# Usage:
#   ./scripts/install.sh              # install
#   ./scripts/install.sh --dry-run   # show what would be linked
#   ./scripts/install.sh --uninstall # remove all managed symlinks
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DRY_RUN=false
UNINSTALL=false

for arg in "$@"; do
  case "$arg" in
    --dry-run)   DRY_RUN=true ;;
    --uninstall) UNINSTALL=true ;;
    *) echo "Unknown flag: $arg" >&2; exit 1 ;;
  esac
done

# ── helpers ──────────────────────────────────────────────────────────────────

run() {
  if $DRY_RUN; then
    echo "  [dry-run] $*"
  else
    "$@"
  fi
}

link() {
  local src="$1" dst="$2"
  local dst_dir; dst_dir="$(dirname "$dst")"
  run mkdir -p "$dst_dir"
  run ln -sfn "$src" "$dst"
  echo "  linked: $dst → $src"
}

unlink_if_managed() {
  local dst="$1" src_prefix="$2"
  if [[ -L "$dst" ]]; then
    local target; target="$(readlink "$dst")"
    if [[ "$target" == "$src_prefix"* ]]; then
      run rm "$dst"
      echo "  removed: $dst"
    fi
  fi
}

# ── Claude Code ───────────────────────────────────────────────────────────────

CLAUDE_SKILLS_DIR="$HOME/.claude/skills"

install_claude() {
  echo ""
  echo "Claude Code → $CLAUDE_SKILLS_DIR/"
  local count=0
  for skill_dir in "$REPO_ROOT"/*/; do
    [[ -f "$skill_dir/SKILL.md" ]] || continue
    local name; name="$(basename "$skill_dir")"
    link "$skill_dir" "$CLAUDE_SKILLS_DIR/$name"
    count=$((count + 1))
  done
  echo "  $count skills installed"
}

uninstall_claude() {
  echo ""
  echo "Claude Code → removing symlinks from $CLAUDE_SKILLS_DIR/"
  if [[ ! -d "$CLAUDE_SKILLS_DIR" ]]; then
    echo "  (directory not found, nothing to do)"
    return
  fi
  for dst in "$CLAUDE_SKILLS_DIR"/*/; do
    [[ -L "${dst%/}" ]] || continue
    unlink_if_managed "${dst%/}" "$REPO_ROOT/"
  done
}

# ── Gemini CLI ────────────────────────────────────────────────────────────────

GEMINI_EXT_SRC="$REPO_ROOT/.gemini/extensions/bigpowers"
GEMINI_EXT_DST="$HOME/.gemini/extensions/bigpowers"

install_gemini() {
  echo ""
  echo "Gemini CLI → $GEMINI_EXT_DST"
  if [[ ! -d "$GEMINI_EXT_SRC" ]]; then
    echo "  WARNING: $GEMINI_EXT_SRC not found — run sync-skills.sh first"
    return
  fi
  link "$GEMINI_EXT_SRC" "$GEMINI_EXT_DST"
}

uninstall_gemini() {
  echo ""
  echo "Gemini CLI → removing $GEMINI_EXT_DST"
  unlink_if_managed "$GEMINI_EXT_DST" "$REPO_ROOT/"
}

# ── Cursor ────────────────────────────────────────────────────────────────────

CURSOR_RULES_SRC="$REPO_ROOT/.cursor/rules"
CURSOR_RULES_DST="$HOME/.cursor/rules"

install_cursor() {
  echo ""
  echo "Cursor → $CURSOR_RULES_DST"
  if [[ ! -d "$CURSOR_RULES_SRC" ]]; then
    echo "  WARNING: $CURSOR_RULES_SRC not found — run sync-skills.sh first"
    return
  fi
  link "$CURSOR_RULES_SRC" "$CURSOR_RULES_DST"
  echo ""
  echo "  NOTE: Cursor does not scan ~/.cursor/rules/ globally."
  echo "  For per-project access, run in your project root:"
  echo "    ln -sfn $CURSOR_RULES_SRC .cursor/rules"
}

uninstall_cursor() {
  echo ""
  echo "Cursor → removing $CURSOR_RULES_DST"
  unlink_if_managed "$CURSOR_RULES_DST" "$REPO_ROOT/"
}

# ── OpenCode ──────────────────────────────────────────────────────────────────

print_opencode_instructions() {
  echo ""
  echo "OpenCode — manual setup (no standard global path):"
  echo "  Add to your project's opencode.json:"
  echo "    {\"rules\": [\"$(ls "$REPO_ROOT"/.cursor/rules/*.mdc 2>/dev/null | head -1 | xargs dirname 2>/dev/null || echo "$REPO_ROOT/.cursor/rules")/**/*.mdc\"]}"
  echo "  Or symlink the rules directory into your project:"
  echo "    ln -sfn $CURSOR_RULES_SRC .cursor/rules"
}

# ── main ──────────────────────────────────────────────────────────────────────

echo "bigpowers install.sh — REPO: $REPO_ROOT"
$DRY_RUN && echo "(dry-run mode — no changes written)"
$UNINSTALL && echo "(uninstall mode)"

if $UNINSTALL; then
  uninstall_claude
  uninstall_gemini
  uninstall_cursor
  echo ""
  echo "bigpowers uninstalled."
else
  install_claude
  install_gemini
  install_cursor
  print_opencode_instructions
  echo ""
  echo "bigpowers installed. Future updates:"
  echo "  git pull && ./scripts/sync-skills.sh"
fi
