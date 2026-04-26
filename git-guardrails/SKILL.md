---
name: git-guardrails
description: Block dangerous git commands (push, force push, reset --hard, clean, branch -D, checkout/restore .) before an AI agent runs them. Installs hook scripts for Claude Code, Cursor, Cursor CLI, and Gemini CLI; documents Google Antigravity Terminal deny lists. Use when the user wants git safety hooks, to block git push or destructive git in agents, or to mirror the same policy across AI coding tools.
---

# Git guardrails

Installs a shared hook that blocks destructive git operations. **Requires `jq` on the agent’s PATH** when the hook runs.

## What gets blocked

- `git push` (including `--force`)
- `git reset --hard`, `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

## Quick start

1. **Scope**: ask project-only vs global (paths differ per product).
2. **Copy the hook bundle** from this skill’s [scripts/](scripts/) to the client’s hooks directory, **keeping** `block-dangerous-git.sh` and `lib/git-guardrails-core.sh` together (the main script sources the core file).
3. **Run `chmod +x`** on `block-dangerous-git.sh`.
4. **Merge** the hook snippet from [REFERENCE.md](REFERENCE.md) into the right settings file—do not wipe unrelated keys.
5. **Verify** with the echo tests in [REFERENCE.md](REFERENCE.md).

| Client | Mechanism | Config |
|--------|-----------|--------|
| Claude Code | `PreToolUse` (Bash) | `.claude/settings.json` or `~/.claude/settings.json` |
| Cursor / Cursor CLI | `beforeShellExecution` | `.cursor/hooks.json` or `~/.cursor/hooks.json` |
| Gemini CLI | `BeforeTool` + `run_shell_command` | `.gemini/settings.json` or `~/.gemini/settings.json` |
| Google Antigravity | Built-in Terminal **Deny list** | Settings UI (no shell hook) |

**Modes (env on the hook command):** `GIT_GUARDRAILS_MODE` is `claude` (default) or `cursor` → stderr + exit `2` on block. Set `gemini` for Gemini CLI → JSON `decision` on stdout (see [REFERENCE.md](REFERENCE.md)).

## Customization

To add or remove patterns, edit `lib/git-guardrails-core.sh` in the copied bundle (array `GIT_GUARDRAILS_PATTERNS`).

## Advanced

Full JSON examples, merge rules, Antigravity deny-list entries, and test commands: [REFERENCE.md](REFERENCE.md).
