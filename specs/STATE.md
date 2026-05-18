# Session State: Project Lifecycle Hardening

## Current Milestone

Remediating audit compliance gaps release by release (v1.14.0 → v1.21.0).
Next up: v1.15.0 — Superpowers Gates.

## Git Metadata

- **Branch**: main
- **Hash**: 6207082

## Completed Releases

- [x] v1.9.0 — Git-worktree lifecycle hardening (kickoff/release scripts)
- [x] v1.11.0 — Gherkin compliance benchmarks (Akita, Karpathy, Clean Code, Pocock, BMAD, Superpowers)
- [x] v1.12.0 — Compliance harness hardening + Clean Code Ch.17 remediation
- [x] v1.12.1 — CONVENTIONS.md: 10 missing heuristics (Boy Scout, G25, G28, N7, C5, G9/F4, T5, T8, verify mandate)
- [x] v1.13.0 — Harness falsification suites + `npm run compliance`
- [x] v1.13.1 — execute-plan + plan-work: PLAN.md → RELEASE-PLAN.md fix
- [x] v1.14.0 — Karpathy behavioral mandates: interpretations gate, loop-until-correct, complexity pushback; 10 evidence scripts (karpathy.feature 10/10 PASS)

## Pending Releases

- [ ] v1.15.0 — Superpowers gates (session bootstrap, red-flag self-check, 94% threshold) — plan: `specs/PLAN-v1.15.0.md`
- [ ] v1.16.0 — Testing mandates (T4/T5/T8 in develop-tdd, Background: blocks) — plan: `specs/PLAN-v1.16.0.md`
- [ ] v1.17.0 — Guardrails: zoom-out mandate, surgical changes discipline
- [ ] v1.18.0 — BMAD lifecycle + issue tracker integration
- [ ] v1.19.0 — Taxonomy metadata (type/context fields, provenance links)
- [ ] v1.20.0 — Architectural complexity (Demeter, concurrency, module depth)
- [ ] v1.21.0 — Developer ergonomics (terse-mode, cold-start handoff)

## Project Capabilities

- **Remediated Clean Code References**: High-fidelity source code examples (ComparisonCompactor, DayDate) resolving Chapter 17 smells.
- **Gherkin Compliance Features**: Authoritative benchmarks for Akita, Karpathy, Clean Code, Pocock, BMAD, and Superpowers.
- **Agentic Compliance Harness**: Binary step-script harness + `npm run compliance` for one-command auditing.
- **Harness Falsification**: Intentional FAIL fixture proves harness honours failures.
- **Skill Consolidation**: plan-release, change-request, assess-impact, trace-requirement added; scope-work, slice-tasks, diagnose-root, grill-with-docs removed.
- **Git-Worktree Lifecycle**: Robust kickoff/release and automated cleanup scripts.
- **Session State Management**: Persistent tracking of project lifecycle phase and git metadata.

## Active Decisions

- **RELEASE-PLAN.md is the single planning artifact** — specs/PLAN.md is retired; plan-work appends to RELEASE-PLAN.md.
- **One plan file per release** — specs/PLAN-vX.Y.Z.md for each upcoming release.
- **Mandatory session start**: read CLAUDE.md → CONVENTIONS.md → specs/STATE.md → specs/RELEASE-PLAN.md before any task.

## Audit Score Tracking

| Version | Score | Notes |
|---------|-------|-------|
| v1.12.0 baseline | ~75% (67/89) | First measured score |
| v1.12.1 | ~84% (~75/89) | +8 from CONVENTIONS.md heuristics |
| v1.14.0 | ~87% (~77/89) | +2 from karpathy.feature (10/10 PASS) |
| v1.16.0 target | ~93% (~83/89) | After superpowers + testing mandates |
