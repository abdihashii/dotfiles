---
name: review-code
description: Reviews a Git diff, branch, PR, or path for verified correctness, security, and regression issues. Uses independent reviewer subagents in parallel when available. Use when asked to review code or a change before merge.
---

# Review Code

Review the requested target. User: $@

## Scope

1. Read applicable project instructions and determine the review target. If none is supplied, review the committed changes ahead of the upstream branch plus uncommitted changes.
2. Read the diff and enough surrounding code to trace changed behavior. Do not modify files.
3. Ignore formatting, generic refactoring ideas, and missing-test suggestions unless they demonstrate a concrete bug in this change.

## Independent review

If an `Agent` tool with a `reviewer` type is available, launch fresh, read-only `reviewer` agents concurrently with `inherit_context` set to `false`.

Choose the count from change risk:

- 2 for a small, local, low-risk change.
- 3 for a normal code change.
- 4 for security, authorization, migrations, concurrency, data integrity, public API changes, or broad cross-cutting work.

Give them distinct scopes. Always include:

1. Correctness and regressions: trace behavior through callers, edge cases, error paths, and state changes.
2. Tests and contracts: check validation, compatibility, public interfaces, and whether existing tests would catch regressions.

For a third reviewer, cover the highest-risk relevant area, such as security, concurrency, data integrity, performance, accessibility, or client-server behavior. For a fourth, cover module boundaries, integration behavior, and structural regressions.

Give each agent the exact review target and ask for concise, evidence-backed findings with `file:line` citations. Reviewers must not edit files. If subagents are unavailable, perform the selected passes sequentially.

## Verify and report

Independently verify every candidate against the source before reporting it. Deduplicate findings and report only issues introduced by the reviewed change with a concrete failure path.

Use this format:

## Findings
- [Important] `path:line` Title: impact and smallest safe fix.
- [Nit] `path:line` Title: confirmed minor issue and smallest safe fix.

If none survive verification, write `## Findings\nNone.` Do not apply fixes unless the user explicitly requests them.
