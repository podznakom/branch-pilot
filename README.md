# branch-pilot [![en](https://img.shields.io/badge/lang-en-blue.svg)](README.md) [![ru](https://img.shields.io/badge/lang-ru-green.svg)](README.ru.md)

> A lightweight Codex branch workflow guard that tells you when to stay, branch out, or split mixed work before implementation.

`branch-pilot` is a standalone repository for one Codex skill with one clear job: look at the current git state right before non-trivial work, then give a short practical branch decision in plain language.

## What It Does

- checks the current branch, status, diff stats, and recent commits
- warns when non-trivial work is happening in `main` or `master`
- suggests 1-3 branch names when a new branch is the safer choice
- tells you to split work when the current changes look mixed
- stays brief, practical, and beginner-friendly

## Who It Is For

- beginners who are still shaky with Git
- vibe-coders who want safer defaults without a Git lecture
- solo builders who do not want to mix multiple tasks in one branch
- Codex users who want branch guidance before risky implementation

## Install In Codex

Step 1: install the skill into Codex.

Ask Codex:

```text
Use $skill-installer to install https://github.com/podznakom/branch-pilot/tree/main/skills/branch-pilot
```

Manual install:

```bash
cp -R skills/branch-pilot ~/.codex/skills/
```

Restart Codex after installation.

## Enable It In A Repo Once

Step 2: in the repository you want to protect, ask Codex:

```text
install branch-pilot
```

You can also say:

- `set up branch-pilot`
- `patch AGENTS.md for branch-pilot`
- `enable branch workflow guard`

That one-time install does two things:

- ensures `.agents/skills/branch-pilot/` exists in that repo
- patches the repo root `AGENTS.md` so Codex calls `$branch-pilot` automatically before non-trivial work

After that, you usually do not need to mention it manually.

## What Happens During Runtime

When `branch-pilot` runs, it quickly inspects the current git state and answers with a short decision:

- stay on current branch
- create a new branch
- split current work
- ready to commit
- ready for PR later

If a new branch is better, it also suggests 1-3 concrete branch names.

## What It Does Not Do Automatically

- create branches
- switch branches
- commit
- push
- merge
- force-push
- change remote state silently

## Example Output

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

## Repository Layout

- [skills/branch-pilot](./skills/branch-pilot/) - the installable skill
- [README.md](./README.md) - English overview
- [README.ru.md](./README.ru.md) - Russian overview

## Why It Helps

- keeps `main` and `master` cleaner
- reduces accidental mixed branches
- makes review and rollback easier
- gives plain-language guidance without slowing normal work

## License

MIT
