---
name: read-x-articles
description: >
  Read X (Twitter) long-form Articles as Markdown. Use when the user shares an
  x.com or twitter.com /article/ URL, asks to read/summarize/fetch an X Article,
  or wants the full text of a Twitter long-form post. Prefer twitter-cli
  (`twitter article`) over browser scraping or the paid X API. Not for ordinary
  tweets (use `twitter tweet`), search, or posting.
license: MIT
compatibility: Requires shell access, network egress, and twitter-cli (or OpenCLI) with X session cookies.
metadata:
  openclaw:
    homepage: https://github.com/lawmight/Home
  agentskills:
    standard: https://agentskills.io/specification
  cursor:
    docs: https://cursor.com/docs/context/skills
  upstream:
    agent-reach: https://github.com/Panniantong/Agent-Reach
    twitter-cli: https://github.com/public-clis/twitter-cli
---

# Read X Articles

Fetch X long-form Articles via **twitter-cli** (the path Agent Reach wires up on this hub). Do not invent browser scrapers or call the paid X API for this.

## Workflow

Progress:

- [ ] Confirm the URL is an Article (`/i/article/` or `/article/`, or a numeric article id)
- [ ] Ensure `twitter` is on PATH and authenticated (`twitter status`)
- [ ] Fetch with `twitter article … --markdown`
- [ ] On failure, follow the retry chain below — then stop and report

### 1. Identify the target

Accept either:

- Full URL: `https://x.com/<user>/article/<id>` or `https://x.com/i/article/<id>`
- Bare article id: `1234567890`

Ordinary status URLs (`/status/…`) are **tweets**, not Articles — use `twitter tweet URL` instead (out of scope for this skill).

### 2. Health check

```bash
command -v twitter >/dev/null || { echo "twitter-cli missing"; exit 1; }
twitter status
```

Expect output containing `ok: true`. If you see `not_authenticated`, stop and follow [references/setup.md](references/setup.md) — do not guess cookies or print secret values.

Optional hub check (when Agent Reach is installed):

```bash
agent-reach doctor --json
```

Prefer the backend reported as active for `twitter` (`twitter-cli` first, then `OpenCLI`).

### 3. Fetch the Article (default)

```bash
twitter article "URL_OR_ID" --markdown
```

Useful variants:

```bash
# Structured for agents
twitter article "URL_OR_ID" --json
twitter article "URL_OR_ID" --yaml

# Write to a temp file (never into the project tree for scratch output)
twitter article "URL_OR_ID" --markdown --output /tmp/x-article.md
```

Or run the wrapper (path relative to this skill directory):

```bash
bash scripts/read-x-article.sh "URL_OR_ID"
```

### 4. Retry chain (stop at first success)

1. Retry once: `twitter article "URL_OR_ID" --markdown`
2. Upgrade CLI: `uv tool upgrade twitter-cli || pipx upgrade twitter-cli` then retry
3. Desktop OpenCLI fallback (browser session): `opencli twitter article "URL_OR_ID" -f yaml`
4. If still failing: tell the user auth/cookies need refresh ([references/setup.md](references/setup.md)). Do **not** fall back to `curl https://r.jina.ai/…` for paywalled / login-gated Articles — it usually returns a shell, not the body.

## Output

- Return the Article title, author handle (if present), and full Markdown body.
- If the user asked for a summary, summarize **from the fetched text** — never from the URL alone.
- Keep temporary files under `/tmp/`.

## Gotchas

- **Cookie auth required** for reliable Article reads. Env vars: `TWITTER_AUTH_TOKEN` + `TWITTER_CT0` (aliases `AUTH_TOKEN` / `CT0` also appear in older docs). Never echo their values.
- **Install**: `uv tool install twitter-cli` or `pipx install twitter-cli` (want v0.8.5+). On this hub, the `agent-reach` stack usually installs it via `agent-reach install --env=auto`.
- **Datacenter IPs** get challenged more often; residential proxy / local session is more reliable. Use a dedicated secondary X account for cookie auth when possible.
- **OpenCLI** works when Chrome is logged into x.com and the OpenCLI extension is present — good desktop fallback, weak on headless cloud VMs.
- Prefer `--markdown` / `--yaml` / `--json` over rich TTY tables when piping to an agent.

## Not this skill

| Ask | Do instead |
| --- | --- |
| Read a normal tweet / thread | `twitter tweet URL` |
| Search X | `twitter search "query"` (flaky; see Agent Reach social retry chain) |
| Post / like / reply | Decline or use an explicit write workflow — out of scope |
| Generic web page | `curl -s "https://r.jina.ai/URL"` |
| Full multi-platform research | Agent Reach skill (`npx skills add Panniantong/Agent-Reach@agent-reach`) |

## References

- Cookie + install details: [references/setup.md](references/setup.md)
- Spec: [agentskills.io/specification](https://agentskills.io/specification)
- Cursor skills dirs: [cursor.com/docs/context/skills](https://cursor.com/docs/context/skills)
- Upstream CLI: [twitter-cli](https://github.com/public-clis/twitter-cli) · router: [Agent Reach](https://github.com/Panniantong/Agent-Reach)
