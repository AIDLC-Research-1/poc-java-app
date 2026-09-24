# Design: /api/ping endpoint

Consumes: `specs/TEST-1.md`

## Impact analysis
- New endpoint only; existing `/api/hello`, `/api/health`, and `/api/version`
  behavior stays unchanged.
- Affects: `src/main/java/com/metlife/poc/` (one new controller) and
  `src/test/java/com/metlife/poc/` (one new controller test).
- Risk: low — no persistence, auth, dependency checks, or business-logic
  integration.
- Migration: none required.

## Design
- Add `PingController` under `com.metlife.poc` with `GET /api/ping`.
- Return the literal response body `pong` with HTTP 200 and
  `text/plain` content so uptime callers get a minimal, deterministic result.
- Keep the implementation self-contained with no request parameters, service
  calls, or dependency probing; this preserves the spec's requirement that the
  endpoint remain independent of business logic.
- Add `PingControllerTest` using the repository's existing direct-controller
  unit-test style to assert the returned value is exactly `pong`.
