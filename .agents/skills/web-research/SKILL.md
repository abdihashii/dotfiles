---
name: web-research
description: |
  Research current web information with Perplexity for general discovery and Firecrawl for page extraction. Use whenever the user asks to search the web, find sources or articles, research a topic, look something up online, compare current information, or find recent news. For mixed developer-contract and general-web questions, split the work between the specialist index and this workflow. Do not use for a known URL only, primary-source developer lookups, paper retrieval, Firecrawl-specific requests, or product code that integrates web APIs.
allowed-tools:
  - Bash(pplx *)
  - Bash(firecrawl *)
---

# Web Research

Use Perplexity to discover sources, then Firecrawl to extract only the sources used in the answer. Native web search and fetch remain disabled.

## Route first

- Known URL only: use `firecrawl scrape` directly.
- A Developer or Research skill explicitly delegated an index or corpus miss, or web-only context: continue with general web discovery below.
- Mixed developer-contract and general-web question: use `firecrawl developer` once for the contract portion, then use this workflow only for the web-only portion. Do not send the contract through general search or bounce between routes.
- Developer API behavior, errors, issues, pull requests, or documentation contracts: use `firecrawl developer`.
- Papers or literature review: use `firecrawl research`.
- General web discovery: follow the workflow below.
- Product code that integrates web APIs: follow the product's requested provider or the relevant build skill. This workflow governs the agent's own research only.

## Discover with Perplexity

Use one short, specific keyword query for a simple lookup. For complex or multi-entity research, send two or three short, non-overlapping queries in one call. Include dates in time-sensitive queries. The whole request gets at most three distinct search queries across all providers.

Always provide one sentence describing the objective with `--intent`, request five results, use medium context, and save results under `.pplx/`:

```bash
pplx search web "short focused query" \
  --intent "Find reputable sources that establish the requested fact" \
  -n 5 \
  --search-context-size medium \
  --output-dir .pplx
```

Pass additional queries as positional arguments when the question needs distinct angles. Read the saved JSON with `jq`. Reuse existing results when they already cover the task.

## Choose evidence, then scrape

Prefer reputable primary sources such as official documentation, original announcements, filings, standards, and first-party data. Use reputable secondary sources for independent reporting, comparison, interpretation, or gaps.

- One direct primary source is enough for a straightforward fact.
- Use two independent reputable sources for disputed, interpretive, or consequential claims.
- Scrape only promising URLs needed to support or validate the answer. One or two rejected candidates are acceptable when rejection requires reading the page.
- Cite each material web-derived claim inline with its scraped source. Put the citation beside the sentence or bullet it supports. Tables need citations in each row or a Sources column; otherwise use bullets. A grouped source list beneath a table is insufficient.

```bash
firecrawl scrape "https://example.com/source" \
  --only-main-content \
  -o .firecrawl/example-source.md
```

If a scrape fails, use another reputable result already found. Use `firecrawl interact` only when the inaccessible page is uniquely necessary.

## Bound retries and fallbacks

- Retry a transient DNS or transport failure once. For rate limits or other provider unavailability, switch directly to `firecrawl search` with the same query intents and disclose the fallback.
- Count query strings, not tool calls: at most three distinct queries across Perplexity, Firecrawl Search, Developer, and Research. Fallbacks may repeat one of those queries on another provider, and a transport retry must repeat the same command. Never introduce a fourth query.
- If evidence remains weak after that budget, stop searching. For low-stakes claims, use the strongest available source with an explicit low-confidence warning. For medical, legal, financial, security, or otherwise consequential claims, report that the claim could not be verified.
- Never use Perplexity snippets as evidence when the underlying page can be scraped.

Keep `.pplx/` and `.firecrawl/` artifacts locally for reuse and inspection. Never commit them.
