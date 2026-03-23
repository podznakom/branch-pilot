# branch-pilot

`branch-pilot` is a small Git workflow guard for Codex. It checks the current branch and worktree, then tells you whether to keep working where you are, move to a new branch, or split mixed changes before continuing.

## What It Does

- checks the current branch, status, diff stats, and recent commits
- warns when non-trivial work is happening in `main` or `master`
- suggests 1-3 branch names when a new branch is the safer choice
- tells you to split work when the current changes look mixed
- stays brief and avoids Git jargon

## How To Install

The first explicit use in a repo can bootstrap installation.

Ask Codex to:

- `use $branch-pilot to check this branch decision`
- `install branch-pilot`
- `set up branch-pilot`
- `patch AGENTS.md for branch-pilot`
- `enable branch workflow guard`

If the repo is not set up yet and you explicitly call `$branch-pilot`, it should first ask whether to patch `AGENTS.md` now so it can run automatically next time.

If you say yes, Codex should:

- ensure `.agents/skills/branch-pilot/` exists
- patch the repository root `AGENTS.md` once with the reusable trigger block
- avoid duplicating that block if it already exists

If the repo does not have an `AGENTS.md` yet, install mode should create one with the branch guard block.

## What Happens After Installation

After the `AGENTS.md` block is in place, Codex should call `$branch-pilot` automatically before non-trivial implementation. The runtime check is intentionally light: it inspects Git state quickly, explains the branch decision in plain language, and then gets out of the way.

If you say no to the bootstrap prompt, `branch-pilot` should still help for that one run, but it should not patch `AGENTS.md`.

## What It Does Not Do Automatically

- create branches
- switch branches
- commit changes
- push changes
- open pull requests
- merge branches
- force-push
- rewrite `AGENTS.md` during normal runtime use

## Example Outputs

```md
### branch-pilot
One-line decision: create a new branch

### why
- You are in `main`.
- This task is larger than a tiny safe edit.
- A separate branch is safer and easier to review.

### do this now
Ask me to create one of these and continue there.
- branch type: feature
- good branch names: feature/auth-form-cleanup, feature/login-error-states, feature/form-validation-pass
```

```md
### branch-pilot
One-line decision: stay on current branch

### why
- This branch already matches the task.
- The current changes still look like one job.
- There is no sign of mixed work.

### do this now
Continue implementation on this branch.
```

## Who It Is For

This skill is for beginners, students, and vibe-coders who want safer branch habits without turning normal development into a slow Git ritual.
