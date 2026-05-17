# Conventional Commits + semantic-style release (reference)

## Message format

From [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/#specification):

```text
<type>[optional scope][optional !]: <description>

[optional body]

[optional footer(s)]
```

- **Scope:** parenthesized noun, e.g. `feat(parser): …`.
- **Breaking:** `!` before `:` (e.g. `feat(api)!: …`) and/or footer `BREAKING CHANGE: description` (token must be uppercase per spec for that footer name).
- **Description:** short summary; body explains *why* or migration steps.

Common **types** (not exhaustive): `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore` — as in [Angular / commitlint conventions](https://github.com/conventional-changelog/commitlint).

## Release type from commits

The table below matches the **idea** used by [semantic-release](https://github.com/semantic-release/semantic-release) with typical **Conventional Commits** / Angular-style presets (e.g. [danielvm-git/semantic-release-baby](https://github.com/danielvm-git/semantic-release-baby) fork of semantic-release, which documents the same commit rules). Exact behavior is **plugin + preset** dependent.

| Commit pattern | Typical release |
|----------------|-----------------|
| `fix:` or patches bug behavior | **Patch** |
| `feat:` | **Minor** |
| `BREAKING CHANGE:` in footer, or `!` after type/scope | **Major** |
| `perf:` (no breaking) | Often **patch** in default angular preset |
| `docs:`, `chore:`, `ci:`, `style:`, `test:` | Often **no** version bump for library consumers — many teams still ship these without semver bump, or use a project-specific rule |

**Major without `feat`:** any type can be major if the footer documents a breaking change.

## Custom repositories

- Read `release.config.js`, `.releaserc`, or `package.json` → `release` / `semantic-release` config.
- The **@semantic-release/commit-analyzer** preset may map types differently; prefer **their** rules when they conflict with this reference.

## Squash and PR titles

- If the team squashes on merge, the **PR title** often becomes the single squashed commit subject — it should still follow `type(scope): description` for tooling.
- `revert:` type and `Refs:` footers are valid patterns; revert handling varies by [tooling](https://www.conventionalcommits.org/en/v1.0.0/#specification).

## Links

- [Conventional Commits — specification](https://www.conventionalcommits.org/en/v1.0.0/#specification)
- [semantic-release — README (commit format & flow)](https://github.com/semantic-release/semantic-release#commit-message-format)
- Fork pointer: [semantic-release-baby](https://github.com/danielvm-git/semantic-release-baby) (automation and docs align with upstream semantic-release)
