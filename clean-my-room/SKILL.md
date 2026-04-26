---
name: clean-my-room
description: >
  Scans the active workspace (or a chosen root) for disposable artifacts—logs, caches,
  stale build output, and stray draft markdown—and proposes consolidation of scattered
  assets and data into a clear layout. Produces a reviewable list, asks for explicit
  confirmation before any delete or move, uses the shell to verify sizes and paths, and
  optionally revises .gitignore so the same junk does not return as noise in git status.
  Use when the user says "clean my room", "limpar o workspace", "workspace cleanup",
  "pós-deploy cleanup", "remove temp files", "organize assets", "gitignore", or wants a safe tidy pass.
---

# Clean my room (workspace cleanup)

## Principles

- **Read-only first**: inventory and size (`du`, `ls -la`) before any change.
- **Never delete or move** without a numbered list and **explicit user approval** (item-level or "approve all").
- **Prefer `fd` / `ripgrep` / `find`** in that order; avoid blind `rm -rf` on vague globs.
- **Do not** touch `.git/`, `node_modules/`, `venv/`, `.env*`, or SSH keys; flag them only if the user asked about them.
- Confirm prompts in the **user’s language** if they are not writing in English.

## 1. Establish scope

- Default: **current project root** (where the user is working) or the path they name.
- Record OS (macOS vs Linux) for ignore patterns (e.g. `.DS_Store`).

## 2. Classify candidates (scan)

Group findings under these **buckets** (adjust names to the repo’s conventions):

| Bucket | Examples | Typical action |
|--------|------------|----------------|
| **Logs & temp** | `*.log`, `logs/`, `tmp/`, `temp/`, `*.log.*`, `npm-debug.log*`, `*.pid` | Delete after confirm |
| **Build / cache** | `dist/`, `build/`, `out/`, `target/`, `.next/`, `coverage/`, `.turbo/`, `*.tsbuildinfo` | Delete if rebuildable; **never** if user needs offline artifacts |
| **Package caches** (optional) | root `.cache/`, `__pycache__/` | Offer delete; warn on broad Python caches in mixed trees |
| **Stray drafts** | root-level `*.md` named `draft`, `scratch`, `temp`, `TODO`, `notes`; or `untitled*.md` | User picks: delete, move to `docs/drafts/`, or keep |
| **Duplicate / dump dirs** | `old/`, `backup/`, `copy/`, `*_backup` | List + ask |

Use quick size hints: `du -sh` per top-level dir; sort large items first.

## 3. Assets & data (organize, not only delete)

If the user wants **organization**:

1. Propose a **single convention**, e.g.:
   - `assets/` — images, fonts, static media (subfolders: `images/`, `fonts/`, `media/`)
   - `data/` — JSON, CSV, fixtures, samples (subfolders: `fixtures/`, `exports/`, `seed/`)
2. For each cluster of loose files, suggest **one target path** and a short rationale.
3. Use **git-aware moves** when in a repo: `git mv` if tracked; otherwise `mv` and report.
4. Never move secrets or production DB dumps into `docs/` or public `assets/`.

## 4. Present the plan

Output a table or numbered list:

- Path
- Kind (log / build / draft / asset / other)
- Approx size
- Proposed action: **delete** | **move to …** | **keep**

Ask: *"Apagar itens 1–3? Mover 4–5? Skip 6?"* (or English equivalent).

## 5. Execute after approval

- Deletes: on macOS, prefer a Trash-capable tool (e.g. `trash` from Homebrew) if installed; else `rm` with paths echoed back.
- Moves: create dirs with `mkdir -p` first; one batch at a time.
- **Verify**: re-run listing on affected parents; if anything failed, report stderr.

## 6. Post-cleanup and `.gitignore` revision

Do this when the repo is under Git and the cleanup surfaced **untracked** noise or **tracked** files that should never have been committed (rare; flag and let the user decouple).

1. **Inventory ignore sources** (in order): root `.gitignore`, `.git/info/exclude`, any **`.gitignore` in subpackages** (monorepos). Skim for sections/comments so new rules go in the right place.
2. **Map findings to rules**: for each deleted or recurring artifact class (logs, `dist/`, OS cruft, editor swap files), check whether a pattern already exists; note gaps, over-broad rules, or duplicates.
3. **Propose a patch**: list only **concrete** changes—`+` add line / `-` remove or narrow / `~` reword—with one-line why. Prefer directory anchors (`/dist/`, `/coverage/`) when the noise is root-only. Never add broad globs (e.g. `*.json`) that could hide real source.
4. **User must approve** the exact diff before editing the file.
5. **Verify**: for 2–3 representative paths, run `git check-ignore -v <path>` and confirm the intended match. Re-run `git status -sb`. If a pattern wrongly ignores something that should be tracked, fix before finishing.
6. **Optional one-line summary**: space freed, paths cleaned, and ignore rules added or tightened.

If the user does **not** want `.gitignore` changes, skip steps 1–5 and only summarize cleanup results.

## Related ideas

- Post-deploy or environment tidying follows the same **classify → show → confirm → act** loop; name buckets after the user’s stack (e.g. Docker `*.log`, k8s tmp, CI artifacts).
- Multi-root “agent template” style repos: respect their `Flow/` vs `Stock/` (or local equivalents)—only move **draft** material within agreed draft areas.

See [REFERENCE.md](REFERENCE.md) for shell patterns, `.gitignore` mechanics, and safety checks.
