---
name: slice-tasks
description: "Break a plan or PRD into independently-grabbable vertical-slice tasks in specs/TASKS.md. Use after scope-work or plan-release, before plan-work, when user wants implementation tickets or tracer-bullet slices.model: sonnet"
---


# Slice Tasks

Produce `specs/TASKS.md` — vertical slices, each independently deliverable and testable.

## Process

1. Read `specs/SCOPE.md` and/or `specs/RELEASE-PLAN.md`.
2. Cut **tracer-bullet slices** (thin end-to-end paths first, then depth).
3. Each task entry: `id`, `title`, `depends-on:` (optional), `verify:` command, `story:` link.
4. Order by WSJF within the file.

> **HARD GATE** — No horizontal-only slices ("add all models") without a vertical path that proves integration.

## Verify

→ verify: `test -f specs/TASKS.md && grep -c "verify:" specs/TASKS.md | awk '{if($1>0) print "OK"; else print "MISSING"}'`
