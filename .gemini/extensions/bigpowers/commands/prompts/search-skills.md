
# Search Skills

Lexical search only — no embedding service (ADR: zero external dependency).

## Process

1. Run `bash scripts/build-skill-index.sh` if `specs/SKILL-SEARCH-INDEX.md` is stale.
2. Search index: `rg -i "<keywords>" specs/SKILL-SEARCH-INDEX.md`
3. Read top 3 matches' `description` and "Use when" triggers.
4. Recommend one skill with rationale; invoke via orchestrator or direct call.

## Verify

→ verify: `test -f specs/SKILL-SEARCH-INDEX.md && echo OK || (bash scripts/build-skill-index.sh && test -f specs/SKILL-SEARCH-INDEX.md && echo OK)`
