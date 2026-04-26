---
name: prepare-semantic-commit
description: Reviews working-tree and session-justified changes, then drafts a Conventional Commits title/body and states the semantic-release–style version bump a single such commit would imply. Use when the user wants to commit recent chat or session work, prepare a Conventional Commits message, or asks for semantic-release / semver-consistent messaging before `git commit`.
---

# Prepare semantic commit (session → Conventional Commits + release bump)

## What “last chat” means

- **Primary source of truth:** `git status`, `git diff` (unstaged), and `git diff --cached` (staged). Run these in the repo root (or the paths the user changed).
- **Context:** use the current conversation to summarize *intent* and to spot **breaking** API/behavior changes that diff alone may not show.
- If the user tracks a session baseline (e.g. branch, tag, or `git stash create` at start), you may `git diff <baseline>..HEAD` plus uncommitted diffs; otherwise use only the index and working tree.

## Quick workflow

1. **Inventory** — List changed paths; group by feature vs chore vs docs vs test-only.
2. **Decide commit shape** — One atomic commit is ideal. If the diff mixes unrelated concerns, recommend **multiple commits** (each with its own type/scope) before suggesting one message.
3. **Classify for semantic release** — Using the [default analyzer-style mapping](REFERENCE.md#release-type-from-commits) (same idea as [semantic-release](https://github.com/semantic-release/semantic-release) / [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)): `fix` → patch, `feat` → minor, **breaking** → major.
4. **Write the message** — `type(optional-scope)!: description` (see [REFERENCE.md](REFERENCE.md#message-format)). Use `!` or a `BREAKING CHANGE:` footer when behavior contracts change.
5. **Deliver** — Output:
   - Proposed **full commit message** (title + optional body + footers).
   - **Release bump** this commit would drive under typical defaults: `patch` | `minor` | `major` | `none` (e.g. `chore`/`ci`/`docs` that do not trigger a version in many setups — say “project-dependent”).
   - **Optional:** `git add …` and `git commit -m` / `git commit` (file) instructions; do **not** run destructive git commands unless the user asked.

## Checklist before finalizing

- [ ] Type matches the **dominant** user-visible outcome (`feat` vs `fix` vs `perf`, etc.).
- [ ] **Scope** is a short noun in parentheses if it helps (e.g. `fix(api): …`).
- [ ] Breaking changes are explicit (`!` and/or `BREAKING CHANGE:` in the body/footer).
- [ ] Description is imperative, lowercase start after the prefix, no trailing period in the title line (common style; match repo if different).

## When not to invent a bump

If the repo uses a custom **@semantic-release/commit-analyzer** preset, note that your bump is **heuristic** and they should match `.releaserc` / `release.config.*`. See [REFERENCE.md](REFERENCE.md#custom-repositories).

## Further reading

- [REFERENCE.md](REFERENCE.md) — Message shape, footers, release mapping, squashing notes.
