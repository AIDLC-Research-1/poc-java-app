# Security review: /api/version endpoint

Reviewed change: `VersionController` (`specs/version-endpoint.md`,
`docs/design/version-endpoint-design.md`).

## Findings
- **Info disclosure (low)**: exposing an app version can help an attacker
  fingerprint known CVEs for that version. Endpoint is unauthenticated in
  this POC. Recommend gating behind existing auth/network perimeter before
  production use — not fixed here (out of security-review's write scope;
  recorded as a finding only).
- No injection, deserialization, or secret-handling issues — endpoint takes
  no input and returns a static map.

## Verdict
PASS with the info-disclosure note above tracked for the release-readiness
gate.
