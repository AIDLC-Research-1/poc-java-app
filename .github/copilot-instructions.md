# Copilot instructions — poc-java-app

Stack: Java 17, Spring Boot 3.3.x, Maven.

## Conventions
- Package root: `com.metlife.poc`.
- REST controllers under `src/main/java/.../*Controller.java`.
- One test class per controller, JUnit 5 + AssertJ, under `src/test/java`.

## Build / lint / test
- Build: `mvn -q -DskipTests package`
- Test: `mvn -q test`
- No dedicated linter configured; keep formatting consistent with existing files.

## Agent boundaries
- Agents must NOT edit `pom.xml` dependency versions without an accompanying
  `docs/design/**` rationale.
- Agents must NOT modify `.github/workflows/**` (CI/CD) or branch protection.
- Agents must NOT merge PRs or trigger deployments — human approval required.
- Security/release agents: read-only, per `attestations/**` / pipeline results only.

## Jira-triggered pipeline
A Jira issue creation dispatches `jira-pipeline.yaml`, which opens a
`stage:spec` issue assigned to Copilot. Each stage's merged PR
(`jira-stage-advance.yaml`) opens the next stage issue automatically:
spec -> impact -> dev -> qa -> security -> read-only release-readiness
verdict. Do not remove `stage:*`/`jira:*` labels from issues/PRs — the
chain relies on them. See `scripts/jira-stage-issue.sh`.
