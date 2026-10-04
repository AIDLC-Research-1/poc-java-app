# Proposed Spec: User details API

**Status: PROPOSED — not approved for design, planning, or implementation.**

## Summary

Define a proposed `POST /api/users` endpoint for submitting minimal user
details. The endpoint, fields, response contract, and storage behavior below
are candidates for review, not approved decisions. No actual user data was
collected for this specification.

## Actors

- A client submitting user details (authentication and authorization
  requirements are undecided).
- The application service responsible for storing an accepted submission after
  an approved persistence design exists.
- Business, privacy, and security reviewers who must confirm the data and
  controls before design or planning.

## Proposed API contract

- **Method and path:** `POST /api/users`.
- **Request media type:** `application/json`.
- **Candidate request fields:** `firstName`, `lastName`, and `email`, proposed
  as required fields. `phone` is not included unless a business need and its
  handling are confirmed.
- **Candidate success response:** `201 Created` only after approved storage
  confirms the submission was saved. The exact response body, including
  whether it contains an identifier, remains undecided. Do not echo submitted
  PII by default.
- **Candidate errors:** malformed or invalid input may receive `400 Bad
  Request`; unsupported media type may receive `415 Unsupported Media Type`.
  The final status codes and safe error schema require approval. Duplicate
  email behavior and its response are undecided.
- **Storage status:** no persistence technology or durability behavior is
  selected. The existing application dependencies do not establish a storage
  mechanism. Do not treat volatile/in-memory storage as durable.
- **Authentication/authorization status:** unresolved. No unauthenticated
  production use is approved by this proposal.

Illustrative request (synthetic values only; not a real user):

```json
{
  "firstName": "Alex",
  "lastName": "Sample",
  "email": "alex.sample@example.invalid"
}
```

## Acceptance criteria

All criteria below are proposals. They require review and must be converted
into tests during an approved implementation stage; no implementation or tests
are claimed here.

- **UDA-AC-01 — Accepted submission:** Given a request conforms to the
  approved field schema and validation rules, When the caller submits it to
  `POST /api/users` using an approved authorization model, Then the application
  returns the approved success response only after the approved storage
  mechanism confirms saving the submission.
  - Planned verification evidence: controller/API test for the approved valid
    request, response, authorization behavior, and storage-success condition.
- **UDA-AC-02 — Missing or blank required values:** Given required fields and
  their limits have been approved, When a request omits a required field,
  supplies a blank value, or exceeds that field's approved length or format
  constraints, Then the application rejects it with the approved client-error
  response and does not store it.
  - Planned verification evidence: parameterized controller/API tests for
    missing, blank, and over-limit values for each approved field.
- **UDA-AC-03 — Malformed input:** Given the request body is malformed JSON or
  contains values of types that do not conform to the approved schema, When it
  is submitted, Then the application rejects it with the approved safe
  client-error response and does not store it.
  - Planned verification evidence: controller/API tests for malformed JSON and
    wrong field types, including confirmation no storage write occurs.
- **UDA-AC-04 — Unsupported content type:** Given a request uses a media type
  not supported by the approved contract, When it is submitted to the
  endpoint, Then the application rejects it with the approved unsupported
  media-type response and does not store it.
  - Planned verification evidence: controller/API test with a non-JSON media
    type and confirmation no storage write occurs.
- **UDA-AC-05 — Duplicate submission:** Given duplicate-email behavior has
  been decided, When a submission conflicts under that decision, Then the
  application follows the approved duplicate policy and returns its approved
  response without exposing another user's details.
  - Planned verification evidence: API/storage integration test for the
    approved duplicate policy. The policy and response are currently
    undecided.
- **UDA-AC-06 — Safe errors and responses:** Given a request is rejected or
  accepted, When the application emits an error, log entry, or response, Then
  it does not include raw submitted field values or unnecessary PII echoes;
  errors provide only approved, non-sensitive information.
  - Planned verification evidence: API tests asserting response contents and
    captured-log tests asserting submitted values are not present.
- **UDA-AC-07 — Access control:** Given the endpoint's intended use and
  environment have been approved, When a caller is unauthenticated or lacks
  required permission, Then the application enforces the approved
  authentication and authorization policy before accepting or storing details.
  - Planned verification evidence: API tests for unauthenticated and
    unauthorized callers under the approved access-control design.

## Security and privacy considerations

These are requirements for review and design, not claims that controls
currently exist:

- Confirm data classification, collection purpose, lawful basis/consent
  requirements, and strict data minimization before approving any fields.
- Exclude date of birth, government identifiers, policyholder data, passwords,
  credentials, and other sensitive data unless a separately approved need and
  safeguards exist.
- Confirm authentication, authorization, least-privilege access, and intended
  exposure before implementation; production use is not approved by this
  proposal.
- For real data, define transport encryption and encryption-at-rest
  requirements, key/access management, and the approved storage architecture
  before planning implementation.
- Define retention, deletion, and any legal hold requirements before choosing
  persistence or accepting data.
- Validate input against approved bounds; return safe, non-identifying errors;
  avoid logging request bodies, raw rejected values, or unnecessary PII.
- Use only synthetic values in examples and tests. Never place secrets,
  customer data, policyholder data, or unredacted production data in Copilot
  Spaces or specification artifacts.

## Out of scope

- Implementing the endpoint, persistence, authentication, authorization, or
  validation.
- Selecting storage, retention, consent, duplicate handling, or production
  readiness without the required decisions and approvals.
- Collecting actual user details in the agent session.
- Adding fields for date of birth, government IDs, policyholder information,
  passwords, or other sensitive data.

## Open questions

1. What is the approved business purpose and intended user population? Is this
   a synthetic-only POC or intended to handle real/production user details?
2. Which exact fields are required or optional? Is there a confirmed business
   need for `phone` or any field beyond the proposed minimal set?
3. What validation rules, lengths, formats, normalization, and international
   input requirements apply to each approved field?
4. What privacy/data classification, lawful basis, and consent notice or
   capture are required?
5. What approved persistence technology and durability guarantees are
   required? What are the retention, deletion, backup, and legal hold rules?
6. What authentication and authorization model applies to each caller and
   environment?
7. What is the approved duplicate-email policy, including concurrency behavior
   and response?
8. What exact success/error status codes, response bodies, and identifier
   behavior are approved?
9. What monitoring and audit evidence is needed without logging user PII?

## Context sources

### Space

- Copilot Space name: **not supplied**; confirmation is needed before G1
  approval.
- No actual user data was used or collected in this agent session.

### Files reviewed or supplied as context

- User requirement and governance summary in the issue prompt.
- Application instructions: [`.github/copilot-instructions.md`](../.github/copilot-instructions.md).
- Application stack/dependencies: [`pom.xml`](../pom.xml).
- Existing endpoints: [`HelloController.java`](../src/main/java/com/metlife/poc/HelloController.java)
  and [`VersionController.java`](../src/main/java/com/metlife/poc/VersionController.java).
- Existing spec style: [`version-endpoint.md`](version-endpoint.md).
- Catalog requirements were supplied in the issue prompt. The referenced
  catalog revision was not directly retrievable through the available
  repository interface; these permalinks identify the stated source files and
  revision:
  - [Institutional standards](https://github.com/AIDLC-Research-1/metlife-speckit-catalog/blob/ff65b7c7d88977f0864973f3d13b746b8e870d9a/spaces/institutional/standards.md)
  - [Security baseline](https://github.com/AIDLC-Research-1/metlife-speckit-catalog/blob/ff65b7c7d88977f0864973f3d13b746b8e870d9a/spaces/institutional/security-baseline.md)
  - [Approved stack](https://github.com/AIDLC-Research-1/metlife-speckit-catalog/blob/ff65b7c7d88977f0864973f3d13b746b8e870d9a/spaces/institutional/approved-stack.md)
  - [Governed spec template](https://github.com/AIDLC-Research-1/metlife-speckit-catalog/blob/ff65b7c7d88977f0864973f3d13b746b8e870d9a/presets/metlife-gov/templates/spec-template.md)
  - [BA/spec stage scope](https://github.com/AIDLC-Research-1/metlife-speckit-catalog/blob/ff65b7c7d88977f0864973f3d13b746b8e870d9a/extensions/sdlc-agents/commands/speckit.sdlc-agents.ba-spec.md)
  - [Architect impact stage](https://github.com/AIDLC-Research-1/metlife-speckit-catalog/blob/ff65b7c7d88977f0864973f3d13b746b8e870d9a/extensions/sdlc-agents/commands/speckit.sdlc-agents.architect-impact.md)
  - [Developer stage](https://github.com/AIDLC-Research-1/metlife-speckit-catalog/blob/ff65b7c7d88977f0864973f3d13b746b8e870d9a/extensions/sdlc-agents/commands/speckit.sdlc-agents.developer.md)

### Open context questions

- Confirm the Copilot Space name and whether any additional approved context
  files apply.
- Confirm the business, data-classification, privacy, security, and scope
  decisions listed above. They remain unresolved and require human review.

## Traceability

| Requirement ID | Source (Jira/Reg) | Spec Section | Verification Evidence |
| --- | --- | --- | --- |
| UDA-01 | User request: create an API to collect user details (no Jira ID supplied) | Proposed API contract; UDA-AC-01 | Planned controller/API test for approved valid submission and storage-success response |
| UDA-02 | User request; business field requirements not yet supplied | Proposed API contract; UDA-AC-02 | Planned parameterized API validation tests using approved fields and bounds |
| UDA-03 | Security baseline; input-handling requirement proposed for review | UDA-AC-03 | Planned malformed JSON and schema/type API tests; confirm no storage write |
| UDA-04 | API contract proposal | UDA-AC-04 | Planned unsupported media-type API test; confirm no storage write |
| UDA-05 | Business decision pending | UDA-AC-05; Open questions | Planned duplicate-policy API/storage integration test after policy approval |
| UDA-06 | Security baseline; PII-safe handling | Security and privacy considerations; UDA-AC-06 | Planned safe-response assertions and captured-log test with synthetic values |
| UDA-07 | Security baseline; access-control decision pending | Security and privacy considerations; UDA-AC-07 | Planned authentication/authorization API tests after access-control approval |
| UDA-08 | Institutional standards; governed stage gates and approval sequence | Security Gate checklist; Evidence Notes | Human approval records and stage evidence; not available or claimed in this spec proposal |

## Security Gate checklist

- [ ] Threat model reviewed.
- [ ] Data classification confirmed.
- [ ] Security sign-off recorded before planning.

## Governance and approvals

- This proposal is at the governed BA/spec stage only. G1 Frame through G8
  Evidence must be completed in sequence; no gate may be skipped.
- This proposal does not claim G1 approval or any security, privacy, business,
  or human sign-off. Context source gaps and open questions above remain pending
  for G1.
- Human approval of the spec and security review are required before planning.
- An approved spec is a prerequisite for a separate architect impact/design
  stage under `docs/design/**`; that stage must include the Security Review
  Gate and Evidence Notes.
- Implementation requires the approved spec/design pair and belongs to a later
  developer stage with matching code and tests.
- Only humans merge at G7. No merge or deployment is authorized or claimed.
- No custom persona was selected.

## Evidence Notes

- This change proposes documentation only; no runtime code or tests were
  changed or executed, and no scan evidence is claimed.
- Catalog files were not directly accessible through the repository interface;
  the catalog requirements summarized in the issue prompt were used and the
  cited revision/files are recorded above.
- Planned evidence is described in the traceability table and acceptance
  criteria. Actual test, security-review, approval, or release evidence must be
  recorded by the appropriate later stage.
