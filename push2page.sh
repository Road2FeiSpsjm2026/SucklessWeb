#!/usr/bin/env bash
set -euo pipefail

pnpm build

git fetch origin gh-pages

remote_cname="$(git show origin/gh-pages:CNAME 2>/dev/null || true)"
if [ -n "$remote_cname" ] && [ ! -f dist/CNAME ]; then
  printf '%s\n' "$remote_cname" > dist/CNAME
fi

git add dist
if git diff --cached --quiet; then
  printf '%s\n' 'No dist changes to commit.'
else
  git commit -m 'adding dist subtree'
fi

split_sha="$(git subtree split --prefix dist HEAD)"
git push --force-with-lease=gh-pages origin "${split_sha}:gh-pages"
