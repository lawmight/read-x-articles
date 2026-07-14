# X Article setup (twitter-cli)

Load this when `twitter status` is missing, broken, or `not_authenticated`.

## Install

```bash
# Preferred
uv tool install twitter-cli

# Or
pipx install twitter-cli

# Hub path (installs twitter-cli among other channels)
pip install "https://github.com/Panniantong/agent-reach/archive/main.zip"
agent-reach install --env=auto
agent-reach doctor
```

Upgrade when GraphQL endpoints drift:

```bash
uv tool upgrade twitter-cli || pipx upgrade twitter-cli
```

## Auth (cookies)

twitter-cli uses the same session cookies as the X web client. No official API key.

### Env vars (headless / cloud)

Export (never print values):

```bash
export TWITTER_AUTH_TOKEN='…'   # cookie: auth_token
export TWITTER_CT0='…'          # cookie: ct0
# Some older docs also use AUTH_TOKEN / CT0 — set both pairs if unsure
```

### Via Agent Reach

```bash
# Paste Cookie-Editor export (Header String or JSON) — agent runs this; do not log the paste
agent-reach configure twitter-cookies "<cookie export>"
```

### Cookie-Editor steps (user does this in a browser)

1. Install [Cookie-Editor](https://cookie-editor.com/)
2. Log into [x.com](https://x.com)
3. Cookie-Editor → Export → Header String (or JSON)
4. Hand the export to the agent **in chat secrets / a one-shot paste**, not a committed file

### OpenCLI (desktop fallback)

If Chrome is logged into x.com and OpenCLI is installed:

```bash
opencli twitter article "URL_OR_ID" -f yaml
```

No cookie env vars required — it reuses the browser session.

## Verify

```bash
twitter status
# expect: ok: true

twitter article "https://x.com/i/article/ARTICLE_ID" --markdown | head
```

## Safety

- Prefer a **secondary** X account for agent cookies (ban / credential-exposure risk).
- Do not commit cookies, `.env` files, or auth JSON.
- On this hub, prefer Cursor Runtime Secrets over files in the repo.
- Never print `TWITTER_AUTH_TOKEN`, `TWITTER_CT0`, or raw cookie exports in logs or commits.
