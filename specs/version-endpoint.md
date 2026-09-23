# Spec: /api/version endpoint

## Summary
Expose the running application's version so ops/monitoring can confirm what
build is deployed without inspecting artifacts.

## Actors
- Ops/monitoring caller (any authenticated internal client)

## Acceptance criteria
- Given the app is running, When a client `GET`s `/api/version`,
  Then the response is `200` with a JSON body `{"version": "<string>"}`.
- Given no version is configured, When the endpoint is called,
  Then it returns `"unknown"` rather than erroring.

## Out of scope
- Build/CI metadata (git SHA, build timestamp) — future spec.

## Open questions
- None.
