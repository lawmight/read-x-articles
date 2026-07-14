#!/usr/bin/env bash
# Fetch an X (Twitter) Article as Markdown via twitter-cli.
# Usage: read-x-article.sh <article-url-or-id> [output-path]
set -euo pipefail

TARGET="${1:-}"
OUT="${2:-}"

if [[ -z "$TARGET" ]]; then
  echo "usage: $0 <article-url-or-id> [output-path]" >&2
  exit 2
fi

if ! command -v twitter >/dev/null 2>&1; then
  echo "twitter-cli not found. Install: uv tool install twitter-cli" >&2
  echo "Setup notes: $(cd "$(dirname "$0")/.." && pwd)/references/setup.md" >&2
  exit 1
fi

if ! twitter status 2>/dev/null | grep -q 'ok: true'; then
  echo "twitter-cli is not authenticated (twitter status != ok: true)." >&2
  echo "See references/setup.md — set TWITTER_AUTH_TOKEN + TWITTER_CT0 (do not print them)." >&2
  exit 1
fi

if [[ -n "$OUT" ]]; then
  twitter article "$TARGET" --markdown --output "$OUT"
  echo "Wrote $OUT"
else
  twitter article "$TARGET" --markdown
fi
