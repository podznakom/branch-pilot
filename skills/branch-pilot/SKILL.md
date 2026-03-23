---
name: branch-pilot
description: Decide whether implementation should continue in the current git branch or move to a new one. Use before non-trivial implementation, when working on main/master, when task scope changes, when changes look mixed, or before commit/push/merge decisions. Do not use for tiny safe typo-only edits.
---

# branch-pilot

Keep branch guidance short, practical, and safe.

## Modes

Use these stages in order:

- Bootstrap check: on the first explicit use of `$branch-pilot` in a repo that is not installed yet, first ask whether to patch `AGENTS.md` now.
- Install mode: patch repo instructions after the user explicitly asks to install, change auto-switch settings, or agrees to the bootstrap prompt.
- Runtime mode: decide whether work should stay in the current branch or move before non-trivial implementation or before commit, push, or merge decisions.

## Bootstrap Check

If the user explicitly invokes `$branch-pilot` and the repository root `AGENTS.md` does not already contain the `branch workflow guard` block:

- Treat the repo as not installed yet.
- Ask one short yes/no question before normal branch advice:
  - `This repo is not set up for automatic branch checks yet. Do you want me to patch AGENTS.md now so I can run automatically next time?`
- Do not patch `AGENTS.md` until the user agrees.
- If the user agrees, ask one more short yes/no question:
  - `Do you also want to allow automatic local branch switching in this repo when I recommend a new branch?`
- Run Install Mode first, apply the user's auto-switch choice, confirm briefly, then continue with the current runtime decision.
- If the user declines, continue with this one runtime check without patching `AGENTS.md`.
- Do not keep repeating the same install prompt in the same turn.

## Install Mode

Enter install mode when either is true:

- the user says things like `install branch-pilot`, `set up branch-pilot`, `patch AGENTS.md for branch-pilot`, `enable branch workflow guard`, `enable automatic branch switching for branch-pilot`, or `disable automatic branch switching for branch-pilot`
- the user explicitly invoked `$branch-pilot` in an uninstalled repo and then agreed to the bootstrap prompt

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
4. If the user explicitly enabled automatic branch switching, ensure this exact line exists directly below the block:
   - `Auto branch switching for branch-pilot: enabled.`
   - Add it only once.
5. If the user explicitly disabled automatic branch switching, remove that exact line if it exists.
6. Confirm briefly that automatic branch checks are enabled, and say whether automatic local branch switching is enabled or disabled for this repo.
7. If install mode started from the bootstrap prompt, continue with the current runtime decision after the install is done.

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

Do not patch `AGENTS.md` without the user's yes. Outside install mode, do not rewrite `AGENTS.md`.

## Auto-Switch Setting

Treat automatic local branch switching as enabled only when the repository root `AGENTS.md` contains this exact line:

`Auto branch switching for branch-pilot: enabled.`

Add or remove that line only when the user explicitly agrees or explicitly asks to change the setting.

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

## Auto-Switch Behavior

If automatic local branch switching is enabled and `create a new branch` is the right decision:

- Choose the first good branch name, unless one recommended branch already exists and clearly matches the task.
- Prefer local-only commands:
  - `git switch -c <name>` when the branch does not exist yet
  - `git switch <name>` when the branch already exists
- Carry current work to the new branch only if the worktree is clean or the current changes are one logical task.
- Stop instead of switching if changes are mixed, HEAD is detached, or git indicates merge, rebase, cherry-pick, revert, or bisect state.
- Say one short line first with the planned branch name.
- If the switch fails, stop and explain the failure briefly.
- After switching, continue work on the new branch.

## Safety Rules

- Do not create or switch branches unless the user explicitly asks or this repo has explicit auto-switch opt-in enabled for `branch-pilot`.
- Do not push unless the user explicitly asks.
- Do not merge unless the user explicitly asks.
- Do not force-push.
- Do not change remote state silently.
- Do not rewrite `AGENTS.md` outside install mode.

## Output

If the repo is not installed yet and the user explicitly invoked `$branch-pilot`, ask this before normal branch output:

`This repo is not set up for automatic branch checks yet. Do you want me to patch AGENTS.md now so I can run automatically next time?`

After the user answers, either run Install Mode and continue, or continue with one-off runtime advice without patching.

If automatic local branch switching is enabled and a new branch will be used, also include:

- `auto-switch: enabled`
- `planned branch: <name>`

Then create or switch branch after the explanation if it is safe to do so.

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
