# Release Plan: Agentic Compliance & Quality Roadmap

This document outlines the sequential strategy for building our model-judged compliance infrastructure and remediating codebase quality gaps.

## Release Sequence

| Release | Status | Focus | Objective | Bump |
| :--- | :--- | :--- | :--- | :--- |
| **v1.11.0** | ✅ | Benchmarks | Define compliance reference features (Gherkin benchmarks) | Minor |
| **v1.12.0** | ⏳ | Auditor | Stabilize Agentic Auditor harness (LLM fallback & caching) | Minor |
| **v1.12.1** | ⏳ | Harness | Add harness self-testing (falsification suites) | Patch |
| **v1.13.0** | ⏳ | Remediation | Remediate Clean Code (Chapter 17) & Akita smells | Minor |
| **v1.14.0** | ⏳ | Taxonomy | Metadata standards (Provenance, Type, Context) | Minor |
| **v1.15.0** | ⏳ | Branding | F.I.R.S.T test rubric & Pre-condition mandates | Minor |
| **v1.16.0** | ⏳ | Lifecycle | BMAD spec elaboration (Business Analysis & UX) | Minor |
| **v1.17.0** | ⏳ | Guardrails | "Think Before Coding" & "Zoom-out" safety skills | Minor |
| **v1.18.0** | ⏳ | Complexity | Surgical changes, Concurrency safety, & Law of Demeter | Minor |
| **v1.19.0** | ⏳ | Ergonomics | Terse-mode optimization & Handoff utility | Minor |
| **v1.20.0** | ⏳ | Ecosystem | Integrations, Tracking, & Architecture sustained skill | Minor |

---

## Detailed Action Items

### v1.11.0: Compliance Reference Features
- Create authoritative Gherkin benchmarks for: Akita, Karpathy, Clean Code, Pocock, BMAD, and Superpowers.

### v1.12.0: Compliance Auditor Stabilization
- Implement caching, model fallback logic, and `npm run compliance` integration.

### v1.12.1: Harness Quality Assurance
- Implement "Falsification" tests: verify that intentionally broken scripts trigger an audit FAIL.

### v1.13.0: Remediation (Clean Code & Akita)
- Chapter 17 (N7, G29) remediation.
- Implement 'Provenance', 'Remediation Hint' and 'Law of Demeter' signals.

### v1.14.0: Taxonomy Metadata
- Add `type:` (feat/fix/refactor) and `context:` (domain/infra) to implementation plans.

### v1.15.0: Process Branding & Mandates
- Enforce F.I.R.S.T testing. Refactor features to include mandatory `Background:` pre-conditions.

### v1.16.0: BMAD Lifecycle Expansion
- Expand `elaborate-spec` to include explicit Business Analysis (Value Prop) and UX Validation.

### v1.17.0: Guardrails & Safety
- Implement "Think Before Coding" (assumption surfacing) gate and "Zoom-out" (system-context) utility.

### v1.18.0: Architectural Complexity
- Audit checklist: "Surgical Changes", "Concurrency Safety" (shared mutable state), and module depth vs. interface breadth.

### v1.19.0: Developer Ergonomics
- `terse-mode` (token reduction) and `handoff` (cold-start state compacting).

### v1.20.0: Ecosystem Integration
- Issue tracker sync skills (`to-issues`, `triage`) and sustained architecture skill.
