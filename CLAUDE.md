# [Project Name] — Claude Code

Read CONVENTIONS.md before any GitHub or git operation.

## Project

[One sentence. What this codebase does.]
Stack: [language, framework, runtime]

## Commands

| Action | Command |
|--------|---------|
| Run    | `[cmd]` |
| Test   | `[cmd]` |
| Build  | `[cmd]` |
| Lint   | `[cmd]` |

## Architecture

[1–2 sentences. Key modules and their relationships. No implementation details.]

## Conventions

- [e.g. Named exports only]
- [e.g. All queries go through the repository layer]

## Never

- [Hard stop — e.g. Never touch legacy/]
- [Hard stop — e.g. Never run seed in production]

## Agent Rules

- Read specs/ and CONVENTIONS.md before writing code.
- Write the minimum code that solves the stated problem. Nothing extra.
- Never refactor, rename, or reorganize code outside the task scope.
- Run tests after every change. Show evidence before declaring done.
- One clarifying question beats a wrong assumption baked into 200 lines.
- All written output (plans, specs, investigations) goes in specs/.
