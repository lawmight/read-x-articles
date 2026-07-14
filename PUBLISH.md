# How to list this on cursor.directory / skills.sh

This folder is a **standalone Cursor plugin** (ready to be its own public GitHub repo).

`lawmight/Home` is private and this cloud agent cannot create new public repos or sign into cursor.directory as you. Do this once on your machine:

## 1. Create the public repo and push

```bash
# from a clone of Home on branch cursor-read-x-articles-skill-b569:
cd publish/read-x-articles
git init -b main
git add .
git commit -m "Initial read-x-articles Cursor skill plugin"
gh repo create lawmight/read-x-articles --public --source=. --remote=origin --push
```

## 2. List on cursor.directory (community)

1. Open https://cursor.directory/plugins/new
2. Sign in with GitHub
3. Paste `https://github.com/lawmight/read-x-articles`
4. Submit (auto-detects `skills/*/SKILL.md` + `.cursor-plugin/plugin.json`)

## 3. Appear on skills.sh (open Agent Skills directory)

```bash
npx skills add lawmight/read-x-articles -y
```

No submission form — skills.sh indexes via install telemetry. Page will be:

https://skills.sh/lawmight/read-x-articles/read-x-articles

## 4. Optional: official Cursor Marketplace

https://cursor.com/marketplace/publish (manual review).
