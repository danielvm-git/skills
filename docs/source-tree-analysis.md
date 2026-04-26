# Source tree analysis — `skills`

**Scan:** quick (pattern-based, April 2026)  
**Root:** repository root (clone of [github.com/danielvm-git/skills](https://github.com/danielvm-git/skills))

## Annotated layout

```text
skills/
├── README.md              # Human-facing install + skill catalog (source of truth for npx skills)
├── LICENSE
├── skills-lock.json       # Lock file for npx skills installs (hashes per skill)
├── scripts/               # Bash installers (rsync skills → ~/.cursor/skills or project .cursor/skills)
│   ├── install-cursor-skills.sh
│   └── install-cursor-skills-local.sh
├── docs/                  # Project knowledge (this scan + BMAD project_knowledge target)
├── _bmad/                 # BMad Method installer output (config, scripts, manifests)
├── _bmad-output/          # BMad-generated planning/implementation artifacts (when used)
├── .claude/               # Claude Code plugin layout (may mirror skills under skills/)
├── .agent/                # Agent skills mirror (includes large bmad-* subtree)
├── .agents/               # Additional agent path used by skills CLI for project installs
├── .openhands/            # OpenHands-related config (minimal)
├── caveman/               # Example: top-level skill folder → SKILL.md + optional resources
├── tdd/
├── …                      # Other top-level skill directories (24 SKILL.md at depth ≤2, excluding dot dirs)
└── test-skill/            # Fixture / example skill
```

## Critical directories (library / skills collection)

| Path | Role |
|------|------|
| `*/SKILL.md` | Each publishable skill: YAML frontmatter (`name`, `description`, …) + instructions |
| `scripts/` | Non-Node install path for Cursor (`SOURCE_DIR`, `TARGET_DIR` overrides) |
| `_bmad/` | BMad BMM config, customization resolver, manifests |
| `docs/` | Brownfield documentation for AI + `project-scan-report.json` state |
| `.claude/`, `.agent/` | IDE/agent copies of skills; **note** duplication with root skills for some BMad packs |

## Entry points

- **Consumers:** `README.md` → `npx skills@latest add …` or `scripts/install-cursor-skills*.sh`
- **Skill author:** `write-a-skill/SKILL.md`, folder-per-skill convention at repo root
- **BMad:** `_bmad/bmm/config.yaml` (`project_knowledge` → `docs/`)

## Integration points

Single cohesive repository; no separate client/server parts. External integration is **via GitHub** (skills CLI pulls from `danielvm-git/skills` or forks).
