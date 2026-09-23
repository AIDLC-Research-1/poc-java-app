# poc-java-app

Minimal Spring Boot POC app for the GitHub-native AI-SDLC proof of concept.

## Stack
Java 17, Spring Boot 3.3.x, Maven.

## Endpoints
- `GET /api/hello` — static greeting.
- `GET /api/version` — returns `{"version": "0.1.0"}`.

## Build / test
```sh
mvn -q -DskipTests package   # build
mvn -q test                  # test
```
CI runs both on every PR (`.github/workflows/ci.yml`).

## Repo layout
- `src/main/java/com/metlife/poc/` — controllers + application entrypoint.
- `src/test/java/com/metlife/poc/` — JUnit 5 + AssertJ tests.
- `specs/`, `docs/design/`, `attestations/` — pipeline artefacts (see below).

## Copilot agents
- `.github/copilot-instructions.md` — stack conventions and agent boundaries.
- `.github/workflows/copilot-setup-steps.yml` — dev-container/setup steps for Copilot's cloud coding agent.
- Org-level agent personas (`ba-spec`, `architect-impact`, `developer`, `qa-test`,
  `security-review`, `release-readiness`) live in
  [AIDLC-Research-1/.github-private](https://github.com/AIDLC-Research-1/.github-private)
  and are visible org-wide in Copilot Chat.

## Jira-triggered pipeline
A Jira issue creation event (via Jira Automation → `repository_dispatch`)
kicks off a 5-stage chain, each stage a Copilot-assigned issue whose merged
PR (human-approved — branch protection requires 1 review) triggers the next:

```
spec -> impact -> dev -> qa -> security -> release-readiness (read-only verdict)
```

- `.github/workflows/jira-pipeline.yaml` — entry point (stage 1: spec).
- `.github/workflows/jira-stage-advance.yaml` — chains stages 2-5 on PR merge.
- `.github/workflows/jira-pr-label-sync.yaml` — copies `stage:*`/`jira:*`
  labels from a stage issue onto the PR Copilot opens for it.
- The actual stage logic is a **reusable workflow** hosted in
  `AIDLC-Research-1/.github-private` (`jira-stage-issue-reusable.yaml`,
  `release-readiness-check-reusable.yaml`) — kept there, not duplicated
  here, since it's identical to `poc-cobol-app`'s copy.

No stage in this chain can merge or deploy on its own; every PR requires a
human approval.
