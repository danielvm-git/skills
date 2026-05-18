# Plan: v1.14.0 → v1.16.0 — Behavioral Mandates, Gates, Testing

## Context

Three releases that fix failing audit steps in karpathy.feature, superpowers.feature, and
cleancode.feature. All changes are to Markdown — SKILL.md files, CONVENTIONS.md, CLAUDE.md,
and Gherkin feature files. No code is written.

Audit baseline: ~84% (~75/89). Target after v1.16.0: ~93% (~83/89).

---

## v1.14.0 — Karpathy Behavioral Mandates

Fixes 3 failing steps in `karpathy.feature`:
- "present multiple interpretations of ambiguous requests"
- "loop until behavioral correctness is verified"
- "push back on unnecessary complexity"

### Step 1 — Multiple interpretations gate in `elaborate-spec`

Add to Step 2 "Ask clarifying questions": if the request admits ≥2 valid interpretations,
list them all and ask the user to choose before proceeding. No code, no plan, until resolved.

→ verify: `grep -c "interpretation" elaborate-spec/SKILL.md`

### Step 2 — Multiple interpretations gate in `plan-work`

Add to Pre-flight: "If the task statement admits ≥2 valid interpretations, present them and
get a decision before drafting any steps."

→ verify: `grep -c "interpretation" plan-work/SKILL.md`

### Step 3 — Loop-until-correct rule in `validate-fix`

Add to the Rules section: "A mechanical verify pass is not enough — behavioral correctness
must be confirmed. If behavior is wrong, loop back to Step 1."

→ verify: `grep -c "behavioral correctness\|loop" validate-fix/SKILL.md`

### Step 4 — Loop-until-correct note in `execute-plan`

Add to Step 2d Checkpoint: "Mechanical verify passing ≠ behavioral correctness. If behavior
is wrong after verify passes, fix and re-verify before proceeding."

→ verify: `grep -c "behavioral" execute-plan/SKILL.md`

### Step 5 — Complexity pushback gate in `plan-work`

Add to Step 2 "Draft steps": "For any step that introduces a new abstraction (interface,
wrapper, helper), add a one-sentence forcing function: 'This abstraction is needed because…'
If you cannot fill that sentence, remove the abstraction."

→ verify: `grep -c "abstraction\|forcing" plan-work/SKILL.md`

### Step 6 — Sync and audit

→ verify: `bash scripts/sync-skills.sh 2>&1 | grep "skills synced"`

→ verify: `npm run compliance 2>&1 | grep -E "PASS|FAIL" | tail -8`

---

## v1.15.0 — Superpowers Gates

Fixes 3 failing steps in `superpowers.feature`:
- "automatically bootstrap project context at session start"
- "detect red flag rationalizations in my own thought process"
- "reject PRs that do not meet the 94% quality threshold"

### Step 7 — Auto-bootstrap session context in `CLAUDE.md`

Add a "## Session Start" section to Agent Rules (before the bullet list). Phrased as a
mandatory sequence, not opt-in: "Before any task: (1) read CLAUDE.md, (2) read CONVENTIONS.md,
(3) check specs/ for active RELEASE-PLAN.md and STATE.md."

→ verify: `grep -c "Session Start\|bootstrap\|Before any task" CLAUDE.md`

### Step 8 — Red-flag self-check in `plan-work`

Add after Step 2 "Draft steps": "**Red-flag check** — before finalizing the plan, name any
rationalization you caught yourself making for skipping a gate, adding out-of-scope steps, or
omitting a verify command. Write them out; do not suppress them."

→ verify: `grep -c "rationalization\|red.flag\|Red.flag" plan-work/SKILL.md`

### Step 9 — Red-flag section in `audit-code`

Add a "### Red Flags" section at the end of the checklist: "Name any rationalization you
caught during this audit for skipping a checklist item. If you skipped an item, state the
reason explicitly — silence is not acceptable."

→ verify: `grep -c "rationalization\|Red Flag" audit-code/SKILL.md`

### Step 10 — 94% quality threshold in `request-review`

Add to Step 3 "Collect the report": compute a quality score as
`100 × (total_items − must_fix − should_fix) / total_items`. Report the score.
Add a HARD-GATE: if score < 94%, do not merge — run `respond-review` first.

→ verify: `grep -c "94%" request-review/SKILL.md`

### Step 11 — Sync and audit

→ verify: `bash scripts/sync-skills.sh 2>&1 | grep "skills synced"`

→ verify: `npm run compliance 2>&1 | grep -E "PASS|FAIL" | tail -8`

---

## v1.16.0 — Testing Mandates

Fixes 3 failing steps in `cleancode.feature` "Professional Testing" scenario:
- "no Ignored Tests without an explicit ambiguity note (T4)"
- "boundary conditions exhaustively tested (T5)" — needs explicit develop-tdd checklist entry
- "Background: pre-conditions" — none of the 8 feature files have a Background: block yet

### Step 12 — T4 prohibition in `CONVENTIONS.md`

Add to the testing section: "Never skip or `@ignore` a test without an ambiguity note
explaining exactly what is unresolved. Silently ignored tests are prohibited (T4)."

→ verify: `grep -c "T4\|gnored\|ambiguity note" CONVENTIONS.md`

### Step 13 — T4/T5/T8 explicit items in `develop-tdd` Checklist Per Cycle

Expand the checklist at the bottom of develop-tdd/SKILL.md:

```
[ ] No test is ignored without an explicit ambiguity note (T4)
[ ] Boundary conditions tested: empty, max, min, off-by-one (T5)
[ ] Tests verify behavior through public interface only (T8)
```

→ verify: `grep -c "T4\|T5\|T8\|boundary\|ambiguity note" develop-tdd/SKILL.md`

### Step 14 — Background: blocks in feature files

No feature file has a `Background:` block. Add one to any file with a repeated `Given`
clause across ≥2 scenarios. `cleancode.feature` has 4 scenarios all starting with
`Given the codebase exists` — extract to `Background:`.

Also add to: `akita.feature` (2 scenarios, both `Given a project with bigpowers conventions`).

→ verify: `grep -c "Background:" specs/audit/features/cleancode.feature`

→ verify: `grep -c "Background:" specs/audit/features/akita.feature`

### Step 15 — Sync and audit

→ verify: `bash scripts/sync-skills.sh 2>&1 | grep "skills synced"`

→ verify: `npm run compliance 2>&1 | grep -E "PASS|FAIL" | tail -8`

---

## Out of scope

- v1.17.0+ (guardrails, BMAD lifecycle, taxonomy) — separate plan
- Fixing existing test failures unrelated to the three feature files above
- Modifying bmad skills or generated artifacts directly

## Risks

- `plan-work/SKILL.md` is at 96 lines; Steps 2, 5, and 8 all add to it. If it exceeds
  130 lines, extract the red-flag and complexity sections to `plan-work/REFERENCE.md`.
- `develop-tdd/SKILL.md` is already 137 lines; any additions should be terse (1–2 lines each).
- The 94% threshold formula in Step 10 must be worded so it applies to review findings,
  not audit checklist items — confirm with user before writing.
