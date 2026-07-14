# Read X Articles

Cursor / Agent Skills plugin that fetches **X (Twitter) long-form Articles** as Markdown using `twitter-cli` (the path [Agent Reach](https://github.com/Panniantong/Agent-Reach) wires up).

## Install

```bash
npx skills add lawmight/read-x-articles
```

Or in Cursor: Customize → add remote / install from GitHub.

## Usage

Share an Article URL (`https://x.com/…/article/…`) and ask the agent to read it. It will run:

```bash
twitter article "URL" --markdown
```

Needs cookie auth (`TWITTER_AUTH_TOKEN` + `TWITTER_CT0`). See `skills/read-x-articles/references/setup.md`.

## Related (already in the directory)

If you only need a general X→Markdown tool, prefer the existing:

- [`baoyu-danger-x-to-markdown`](https://skills.sh/jimliu/baoyu-skills/baoyu-danger-x-to-markdown) (~25k installs)
- [`agent-reach`](https://skills.sh/panniantong/agent-reach/agent-reach)
- [`twitter-cli`](https://skills.sh/jackwener/twitter-cli/twitter-cli)

This plugin is a **narrow** skill: Articles via `twitter article`, with hub-friendly setup notes.

## Publish surfaces

| Surface | How |
| --- | --- |
| [cursor.directory](https://cursor.directory/plugins/new) | Sign in → paste this repo URL → Submit |
| [skills.sh](https://skills.sh) | Auto-indexes after `npx skills add lawmight/read-x-articles` |
| [Cursor Marketplace](https://cursor.com/marketplace/publish) | Optional; manual review |

## License

MIT
