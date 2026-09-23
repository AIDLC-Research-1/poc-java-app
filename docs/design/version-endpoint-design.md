# Design: /api/version endpoint

Consumes: `specs/version-endpoint.md`

## Impact analysis
- New endpoint only; no existing routes touched.
- Affects: `src/main/java/com/metlife/poc/` (one new controller).
- Risk: low — no persistence, no auth changes.
- Migration: none required.

## Design
- Add `VersionController` with `GET /api/version`.
- Version value hardcoded to `"0.1.0"` for this POC (matches `pom.xml`
  `<version>`); no build-time injection wired up yet — flagged as a known
  gap, not solved here per spec's declared out-of-scope.
