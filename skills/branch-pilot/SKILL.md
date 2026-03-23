---
name: branch-pilot
description: Decide whether implementation should continue in the current git branch or move to a new one. Use before non-trivial implementation, when working on main/master, when task scope changes, when changes look mixed, or before commit/push/merge decisions. Do not use for tiny safe typo-only edits.
---

# branch-pilot

Keep branch guidance short, practical, and safe.

## Modes

Use exactly one mode:

- Install mode: the user explicitly asks to install, enable, or patch repo instructions for `branch-pilot`.
- Runtime mode: decide whether work should stay in the current branch or move before non-trivial implementation or before commit, push, or merge decisions.

## Install Mode

Enter install mode only when the user says things like `install branch-pilot`, `set up branch-pilot`, `patch AGENTS.md for branch-pilot`, or `enable branch workflow guard`.

Do this:

1. Inspect the repository root `AGENTS.md`.
2. Ensure this skill package exists at `.agents/skills/branch-pilot/`.
   - If the current skill already lives there, do not duplicate it.
   - If it does not, copy this skill package there.
3. Insert the exact block below into root `AGENTS.md` if it is missing.
   - Keep `AGENTS.md` compact.
   - Do not duplicate the block.
   - Do not rewrite unrelated sections.
   - If `AGENTS.md` does not exist, create it with this block.
4. Confirm briefly that `branch-pilot` is installed.

Insert this exact block:

```md
## branch workflow guard

Before non-trivial implementation, call `$branch-pilot`.

Treat work as non-trivial if at least one is true:
- current branch is `main` or `master`
- more than one file is likely to change
- task changes behavior, routing, config, schema, auth, data flow, or project structure
- current worktree already contains mixed or unrelated changes
- task scope changed during work

Skip `$branch-pilot` only for tiny safe edits:
- typo fixes
- very small docs wording edits
- single-line harmless corrections

When called, `$branch-pilot` must:
- inspect the current git state
- decide whether to stay on the current branch or recommend a new one
- explain the decision in 1-2 short lines before implementation
- propose 1-3 branch names if a new branch is better
- avoid creating, renaming, deleting, pushing, merging, or force-pushing branches unless explicitly asked
```

Do not patch `AGENTS.md` during normal runtime use.

## Runtime Mode

Move fast. Inspect only what is needed.

- If `scripts/git_snapshot.sh` exists, run it first.
- Otherwise inspect with:
  - `git branch --show-current`
  - `git status --short --branch`
  - `git diff --stat`
  - `git diff --cached --stat`
  - `git log --oneline --decorate -n 10`
- Read full diffs only if the worktree looks ambiguous from status and stat output.

Check:

- current branch
- git status
- staged diff summary
- unstaged diff summary
- recent commits if they help clarify branch intent

## Decision Rules

Stay on the current branch if all are true:

- branch is not `main` or `master`
- changes are one logical task
- branch name already matches the task, or is close enough

Recommend a new branch if any are true:

- current branch is `main` or `master` and the task is not tiny
- task is a feature, fix, refactor, docs change, chore, or hotfix
- more than one file is likely to change
- review or rollback would probably matter

Recommend splitting work if any are true:

- the worktree contains unrelated changes
- one commit would mix different intentions
- the branch has lost focus

Allow direct work in `main` or `master` only if all are true:

- the edit is tiny
- risk is low
- rollback is obvious
- there is no sign that branch or PR workflow is required

Use `ready to commit` when the current branch is focused and the implementation looks complete enough for a clean commit.

Use `ready for PR later` when the current branch is focused, not mixed, and already looks like the right branch for eventual review.

## Naming Guidance

If a new branch is better, recommend 1-3 names that fit:

- `feature/...`
- `fix/...`
- `refactor/...`
- `docs/...`
- `chore/...`
- `hotfix/...`

Use this format:

`type/scope-short-kebab-description`

Keep names short, specific, and easy to understand.

## Safety Rules

- Do not create or switch branches unless the user explicitly asks.
- Do not push unless the user explicitly asks.
- Do not merge unless the user explicitly asks.
- Do not force-push.
- Do not change remote state silently.
- Do not rewrite `AGENTS.md` outside install mode.

## Output

Always respond before implementation with this exact section shape:

```md
### branch-pilot
One-line decision: create a new branch

### why
- reason
- reason
- reason

### do this now
One concrete next step
```

Allowed one-line decisions:

- `stay on current branch`
- `create a new branch`
- `split current work`
- `ready to commit`
- `ready for PR later`

If a new branch is recommended, also include:

- `branch type: <type>`
- `good branch names: <name>, <name>, <name>`

Keep the reasons short, plain, and useful. Explain the branch choice like you are talking to a smart beginner. If moving away from `main` or `master`, briefly explain that it is safer, easier to review, and easier to roll back.

Good runtime phrasing:

- `You are in main, and this task is larger than a tiny safe edit. It is better to do this in a separate branch so the main line stays clean.`
- `This branch already fits the task, so you can safely continue here.`
- `These changes look mixed. It is better to split them before continuing.`

Do not give a Git lecture. Be calm, direct, and practical.
