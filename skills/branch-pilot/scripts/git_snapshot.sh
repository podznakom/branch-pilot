#!/usr/bin/env bash
set -euo pipefail

git rev-parse --is-inside-work-tree >/dev/null 2>&1

echo "BRANCH"
git branch --show-current
echo

echo "STATUS"
git status --short --branch
echo

echo "UNSTAGED_DIFF_STAT"
git diff --stat
echo

echo "STAGED_DIFF_STAT"
git diff --cached --stat
echo

echo "RECENT_COMMITS"
git log --oneline --decorate -n 10
