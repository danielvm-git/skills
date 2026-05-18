
# Survey Context

Read the project's current state and give a phase map + next-skill recommendation. This is the "where am I?" skill — run it at the start of every task.

## Process

### 1. Read CONVENTIONS.md

If `CONVENTIONS.md` exists at the project root, read it first. It contains the rules all agents must follow in this project.

### 2. Read specs/

Scan the `specs/` directory if it exists:

```
specs/
├── CONTEXT.md          → domain model status
├── UBIQUITOUS_LANGUAGE.md → glossary status
├── SCOPE.md            → scope definition status
├── TASKS.md            → task breakdown status
├── PLAN.md             → implementation plan status
├── REFACTOR.md         → refactor plan status
├── DIAGNOSIS.md        → active bug investigation
├── BUG-LOG.md          → historical bug log
└── SPIKE-*.md          → spike learning notes
```

For each file found, note: does it exist? Is it complete? Does it have open items?

### 3. Read CLAUDE.md

If `CLAUDE.md` exists at the project root, read it for project context (stack, commands, architecture, conventions).

### 4. Check git state

```bash
git status --short
git log --oneline -5
git branch --show-current
```

Note: is there a feature branch active? Are there uncommitted changes? Are there unpushed commits?

### 5. Map the lifecycle phase

Based on what you've found, identify which PMBOK phase this project is currently in:

| Phase | Signals |
|-------|---------|
| **Discover** | No specs/ yet, or only rough notes |
| **Design** | specs/SCOPE.md exists but no PLAN.md |
| **Plan** | specs/TASKS.md or PLAN.md exists; on `main`/`master` branch |
| **Initiate** | On a feature branch; no code changes yet |
| **Execute** | PLAN.md exists; on feature branch; steps in progress |
| **Bug** | DIAGNOSIS.md exists; on `main`/`master` |
| **Review** | All code written; no PR yet |
| **Integrate** | PR open; tests passing |
| **Sustain** | Ongoing; no active task |

### 6. Suggest next skill

Based on the phase and state, recommend the most useful next step:

- **If in Plan/Bug phase and on `main`**: Suggest `kickoff-branch` next.
- **If in Initiate phase**: Suggest `develop-tdd` or `execute-plan`.
- **If in Execute phase**: Suggest `develop-tdd` (continue step X) or `execute-plan`.

Example:
```
Phase: Plan
Active branch: main
PLAN.md: exists

Suggested next: kickoff-branch (to create feature/auth branch)
```

Be specific — name the exact skill and why. If multiple options exist, list them in priority order.

### 7. Surface blockers

If something looks wrong:
- Broken tests in the baseline
- DIAGNOSIS.md open with no active fix branch
- PLAN.md with missing verify commands
- CONVENTIONS.md violations in recent commits

Report blockers first, before recommendations.
