---
name: firecrawl-search
description: |
  Run Firecrawl Search only when the user explicitly requests that provider or Perplexity Search is unavailable. Do not use for ordinary web discovery; use the web-research skill instead. Returns search results with optional page content.
allowed-tools:
  - Bash(firecrawl *)
  - Bash(npx firecrawl *)
---

# firecrawl search

Web search with optional content scraping. Returns search results as JSON, optionally with full page content.

## When to use

Use this only when the user explicitly requests Firecrawl Search or Perplexity is unavailable or fails. Disclose fallback use.

## Quick start

```bash
# Basic search
firecrawl search "your query" -o .firecrawl/result.json --json

# News from the past day
firecrawl search "your query" --sources news --tbs qdr:d -o .firecrawl/news.json --json
```

Unless the user explicitly requested Firecrawl Search, use `firecrawl developer` for developer primary sources and `firecrawl research` for papers.

## Options

| Option                                         | Description                                   |
| ---------------------------------------------- | --------------------------------------------- |
| `--limit <n>`                                  | Max number of results                         |
| `--sources <web,images,news>`                  | Source types to search                        |
| `--categories <github,research,pdf,developer>` | Filter by category                            |
| `--tbs <qdr:h\|d\|w\|m\|y>`                    | Time-based search filter                      |
| `--location`                                   | Location for search results                   |
| `--country <code>`                             | Country code for search                       |
| `--scrape`                                     | Also scrape full page content for each result |
| `--scrape-formats`                             | Formats when scraping (default: markdown)     |
| `-o, --output <path>`                          | Output file path                              |
| `--json`                                       | Output as JSON                                |

## Tips

- Select useful results first, then scrape only the URLs used in the answer. Use `--scrape` only when all returned pages are needed.
- Always write results to `.firecrawl/` with `-o` to avoid context window bloat.
- Use `jq` to extract URLs or titles: `jq -r '.data.web[].url' .firecrawl/search.json`
- Naming convention: `.firecrawl/search-{query}.json` or `.firecrawl/search-{query}-scraped.json`

## Feedback

After using results, send one honest, non-blocking `firecrawl search-feedback` call per search for the credit refund. Use `good` with `--valuable-sources`, or `partial`/`bad` with specific `--missing-content`. Skip it when feedback is disabled or the daily cap is reached; feedback never gates the answer.

## See also

- [firecrawl-scrape](../firecrawl-scrape/SKILL.md) — scrape a specific URL
- [firecrawl-map](../firecrawl-map/SKILL.md) — discover URLs within a site
- [firecrawl-crawl](../firecrawl-crawl/SKILL.md) — bulk extract from a site
