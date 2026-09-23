# Spec: /api/ping endpoint

## Summary
Expose a lightweight health endpoint for uptime checks that does not depend on
business logic.

## Actors
- Ops engineer

## Acceptance criteria
- Given the app is running, When a client `GET`s `/api/ping`,
  Then the response is `200` with a plain text body `pong`.
- Given the endpoint is used for uptime checks, When `/api/ping` is called,
  Then it does not require business inputs or depend on business logic.

## Out of scope
- Rich health details or dependency checks.
- Authentication/authorization changes.

## Open questions
- None.
