# Development guide — `skills`

## Prerequisites

- **Git** — clone and contribute.
- **Node.js** — only if using `npx skills` for local verification of installs (optional for editing Markdown only).
- **Bash** — for `scripts/*.sh` (macOS/Linux; Git Bash on Windows).

## Environment setup

1. Clone the repository: `git clone https://github.com/danielvm-git/skills.git` (or your fork).
2. Edit skill content under the appropriate top-level directory.
3. Do **not** commit secrets; skills are public instruction text.

## Install skills locally (contributor testing)

**Preview skill list from GitHub:**

```sh
npx skills@latest add danielvm-git/skills --list
```

**Install all skills for Cursor (global, non-interactive):**

```sh
npx skills@latest add danielvm-git/skills -g -a cursor -y --skill '*'
```

**Install only selected skills:**

```sh
npx skills@latest add danielvm-git/skills -g -a cursor -y --skill tdd --skill caveman
```

Use each skill folder’s `name` field from `SKILL.md` frontmatter. Quoted names if the CLI requires it for spaced titles.

**Project-scoped install (no `-g`):**

```sh
cd /path/to/your-app
npx skills@latest add danielvm-git/skills -a cursor -y --skill '*'
```

Add `--copy` if symlinks are problematic.

## Shell install (no Node)

From a clone:

```sh
./scripts/install-cursor-skills.sh
# or into a specific project:
./scripts/install-cursor-skills-local.sh /path/to/your-app
```

See [README.md](../README.md) for `SOURCE_DIR` / `TARGET_DIR` overrides.

## Build and test

- **No root build.** Run language-specific tests only inside skill folders that define them (e.g. `python3 -m pytest` under a skill’s `scripts/tests/` if present).

## Refresh after upstream changes

```sh
npx skills check
npx skills update
```

Or re-run the `npx skills@latest add …` install command.

## BMad

If using BMad Method artifacts, config lives in `_bmad/bmm/config.yaml` (`project_knowledge` points to `docs/`).
