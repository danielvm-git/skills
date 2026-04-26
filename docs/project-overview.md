# skills — project overview

**Date:** 2026-04-26  
**Type:** library (agent skills collection)  
**Architecture:** flat skill modules + optional BMad / agent mirror trees

## Executive summary

**skills** is a GitHub-hosted collection of **agent skills**: each skill is a directory with a `SKILL.md` file (YAML frontmatter + markdown instructions). The repo is optimized for distribution through the open **`npx skills`** CLI and optional shell installers under `scripts/`. It is **not** a deployable web application; there is no root `package.json` application—content is predominantly Markdown, small scripts, and BMad scaffolding under `_bmad/`.

## Classification

| Dimension | Value |
|-----------|--------|
| Repository type | Monolith (single tree) |
| Project type | `library` (reusable instruction packages for coding agents) |
| Primary “language” | Markdown / YAML frontmatter; Bash for installers |
| Lock / provenance | `skills-lock.json` pins skill hashes from `danielvm-git/skills` |

## Technology stack summary

| Category | Technology | Notes |
|----------|------------|--------|
| Packaging | Agent Skills spec + `skills` CLI | Install via `npx skills@latest add danielvm-git/skills` |
| Docs | README.md, generated `docs/` | Brownfield AI context |
| Automation | Bash (`scripts/*.sh`) | rsync-based Cursor install |
| Planning | BMad (`_bmad/`, `_bmad-output/`) | Optional method integration |

## Key features

- **24** top-level skills (each `*/SKILL.md` at repo root, excluding hidden directories).
- Dual install paths: **Node/npx** (multi-agent) vs **shell** (Cursor paths only).
- Additional copies under `.agent/skills/` and `.claude/skills/` (BMad and duplicates)—treat root folders as canonical published skills unless documenting those trees explicitly.

## Architecture highlights

- **Pattern:** one folder = one skill; progressive disclosure via referenced `.md` / scripts inside the skill folder.
- **Discovery:** agents load by skill `name` from frontmatter; CLI discovers recursive `SKILL.md` from GitHub checkout.

## Development overview

See [development-guide.md](./development-guide.md) for prerequisites and commands. There is **no** repo-wide `npm test` at root; validation is editorial (skill structure) plus optional BMad workflows.
