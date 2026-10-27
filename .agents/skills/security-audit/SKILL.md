---
name: security-audit
description: Audits a Git diff, branch, PR, path, or repository for high-confidence exploitable security vulnerabilities. Reviews attacker-controlled data flow, authorization, secrets, configuration, CI, IaC, and dependency advisories. Use for security-sensitive changes or explicit security audits.
---

# Security Audit

Audit the requested target. User: $@

## Scope and safety

1. Read applicable project instructions. Resolve the target as a diff, branch, PR, path, or repository. With no target, audit changes ahead of the upstream branch plus working-tree changes.
2. Read in-scope code and enough callers, configuration, deployment artifacts, manifests, and lockfiles to understand the effective behavior. Do not modify files, stage changes, install packages, update advisory data, or create reports.
3. Scan relevant tracked source, configuration, CI, IaC, and logging code for exposed secrets. Never reproduce secret material. Report only its `file:line`, apparent type and scope, and rotation or revocation advice.

## Evidence standard

Report a vulnerability only when you can establish all of:

- an attacker-controlled source or compromised trust boundary;
- a reachable sensitive sink or authorization boundary;
- absent or ineffective validation, authorization, escaping, allowlisting, or framework control;
- concrete security impact; and
- `file:line` evidence.

Treat server-controlled configuration, constants, test or dead code, examples, and verified framework protections as non-findings. Do not report theoretical risks, style guidance, or generic hardening advice.

## Review lanes

For a diff, branch, or path, use independent review lanes. If an `Agent` tool with a read-only `reviewer` type is available, launch fresh reviewers concurrently in the foreground with `inherit_context` set to `false`. Otherwise perform the same lanes sequentially.

Choose the count from risk:

- 2 for a small, local, low-risk change: attacker-input-to-sink tracing; secrets, configuration, CI, IaC, and dependencies.
- 3 for normal security-relevant work: add authentication, authorization, ownership, and tenant-boundary analysis.
- 4 for public APIs, payments, authentication, authorization, migrations, concurrency, deserialization, rendering, agent tools, or cloud policy: add the highest-risk surface and cross-module integration analysis.

Give each reviewer the exact target, scope, and lane. Require concise candidate findings with source, control, sink, impact, `file:line`, and refuting evidence checked. Reviewers must not edit files.

For a full-repository audit, run the lanes sequentially unless a dedicated auditor that can report pre-existing vulnerabilities is available.

## Dependency advisories

Detect the package manager from manifests and lockfiles. Run an already-installed native advisory command only when it is read-only. Do not install a scanner or rely on a static CVE list. Verify each advisory against the resolved manifest or lockfile and production reachability before reporting it.

## Final verification and report

Re-read the relevant source for every candidate. Verify data flow, controls, exploitability, and impact independently. Deduplicate survivors.

Use this format:

## Security Audit

### Findings
- [Critical] `path:line` Title: attacker path, impact, and smallest safe fix.
- [High] `path:line` Title: attacker path, impact, and smallest safe fix.
- [Medium] `path:line` Title: attacker path, impact, and smallest safe fix.

If none survive verification, write `## Security Audit\n\n### Findings\nNone.` Do not apply fixes unless the user explicitly requests them.
