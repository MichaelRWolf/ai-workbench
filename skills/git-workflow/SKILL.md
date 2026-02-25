---
name: git-workflow
description: Run my git workflow in this repo—analyze staged files, commit with message, push. Use when I say "analyze", "commit", "push", "stage", or "add".
disable-model-invocation: true
---

# Git Workflow

When I say **"analyze"**, **"commit"**, **"push"**, **"stage"**, or **"add"**, follow these rules in the current repo.

## Permission and safety

- Do not stage, commit, push, or modify the repo unless I explicitly ask (e.g. "commit", "push", "stage these files").
- Never use `--no-verify`. Pre-commit hooks must always run. If hooks fail, report and wait.
- Words like "continue", "resume", "next", "proceed" do not mean "commit".
- Treat "commit", "commit this", "check it in", "analyze and commit" as explicit requests to run `git commit`.

Read-only git is allowed when needed: `git status`, `git diff`, `git diff --cached`, `git show`, `git log`, etc.

## Commit message format

- One line under 60 characters, then a blank line, then a list of changes.

## Commands

**"stage" / "add"**  
Run `git add` with the files I specified. Do not stage anything else.

**"analyze"**

1. Consider only staged files. If nothing is staged, say so and stop.
2. Use read-only git as needed to inspect staged changes.
3. Propose a commit message in the format above and show it in chat.

**"commit"**

1. If nothing is staged, show a warning and stop. Do not run `git commit`.
2. If I just said "analyze", use that message; otherwise generate one.
3. Run `git commit` with that message (no `--no-verify`). Only commit what is already staged.

**"analyze and commit"** / **"analyze then commit"**  
Do "analyze" then "commit" as above. Do not stage for me.

**"push"**  
Run `git push` with no arguments from the project root.
