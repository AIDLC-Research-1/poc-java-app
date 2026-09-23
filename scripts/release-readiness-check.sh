#!/usr/bin/env bash
# Role: release-readiness. Read-only gate check after the security-review
# stage merges. Never writes source/config, never merges, never deploys —
# only posts a verdict comment on the merged PR.
set -euo pipefail

JIRA_KEY="${1:?usage: release-readiness-check.sh <jira_key> <pr_number>}"
PR_NUMBER="${2:?missing pr number}"

MISSING=""
[ -f "specs/${JIRA_KEY}.md" ] || MISSING="${MISSING}- missing specs/${JIRA_KEY}.md\n"
[ -f "docs/design/${JIRA_KEY}.md" ] || MISSING="${MISSING}- missing docs/design/${JIRA_KEY}.md\n"
[ -f "attestations/${JIRA_KEY}-security-review.md" ] || MISSING="${MISSING}- missing attestations/${JIRA_KEY}-security-review.md\n"

if [ -z "$MISSING" ]; then
  VERDICT="PASS: spec, design, and security-review artefacts are all present for ${JIRA_KEY}."
else
  VERDICT="BLOCKED: ${JIRA_KEY} is missing required gate evidence:\n${MISSING}"
fi

printf '%b' "## release-readiness verdict\n\n${VERDICT}\n\nThis is a read-only check — no merge/deploy action was taken." > /tmp/verdict.md
gh pr comment "$PR_NUMBER" --body-file /tmp/verdict.md
