# ai-workbench

Scaffold for building Agent Skills and Agents.

Structure:
- skills/
- agents/
- shared/
- tools/
- scratch/

Includes initial skill: ics_vcf_converter

## Git workflow agent

Use this workflow from **any repo, any directory**—as your personal tool, not a project rule. You do not repeat it in every repo. Cursor does not offer a separate “agent window” with different rules; you use one Agent chat and make the workflow available globally in one of these ways.

### Option A: User Rules (reference by path)

1. Open **Cursor Settings → Rules** (e.g. Cmd+Shift+J), then **User Rules**.
2. Add a single line that points at the workflow file (no pasting):
   - *"When I say 'analyze', 'commit', 'push', 'stage', or 'add', read and follow the instructions in `~/repos/ai-workbench/skills/git-workflow/SKILL.md`."*
   - Or, if you use the global skill (Option B), use **`~/.cursor/skills/git-workflow/SKILL.md`** instead.
3. Every Agent chat will load that file when you use those commands. Adjust the path if your ai-workbench repo lives elsewhere. Same for **`cursor agent`** in the terminal—User Rules apply to the CLI too.

### Option B: Global skill (invoke when you want it)

1. Install the skill once so Cursor loads it in every repo:
   - Create the directory: `mkdir -p ~/.cursor/skills`
   - Copy or symlink: `cp -r skills/git-workflow ~/.cursor/skills/` (or `ln -s /path/to/ai-workbench/skills/git-workflow ~/.cursor/skills/git-workflow`)
2. In any repo, open **Cursor Agent** (or Chat).
3. Type **/git-workflow** then your command, e.g. `/git-workflow analyze`, `/git-workflow commit`, or `/git-workflow push`. The skill loads and the agent runs the workflow in the current repo. Same when you run **`cursor agent`** from the terminal—the CLI uses the same `~/.cursor/skills`.

The canonical workflow lives in **`skills/git-workflow/SKILL.md`**. Edit it here and, if you use Option B, update or re-symlink in `~/.cursor/skills/`.

### In this repo only (project rule)

- The same workflow is in `.cursor/rules/git-workflow.mdc`. If the agent doesn’t follow it, say **@git-workflow** then e.g. “commit” or “push”.

### Running via `cursor agent` (CLI, no Cursor.app)

You can run the agent entirely from the terminal with **`cursor agent`**. No Cursor.app window required. The same User Rules and **`~/.cursor/skills`** apply to the CLI.

1. **Single session**  
   From any repo directory run `cursor agent`. The agent's project root is that directory. Use **/git-workflow** (if you installed the global skill) or say "analyze", "commit", "push" (if User Rules reference the workflow path). Commands run in that repo.

2. **Two sessions (git vs. work)**  
   Run two terminal sessions (e.g. two tabs, or **tmux** windows/panes). In one session run `cursor agent` for main work. In the other run `cursor agent` and use it **only** for git: type **/git-workflow analyze**, **/git-workflow commit**, **/git-workflow push**, or "analyze"/"commit"/"push" if User Rules point at the path. Keeps the git agent's context small. Use tmux to switch between sessions (e.g. `tmux new -s git` for the git-only agent).

3. **Path for User Rules**  
   If you rely on the path in User Rules, use **`~/repos/ai-workbench/skills/git-workflow/SKILL.md`** or **`~/.cursor/skills/git-workflow/SKILL.md`** so the CLI agent can read it from any repo.

### Claude Code (or Claude in browser)

Reference the workflow by **path** so the agent reads it when you need it. No pasting.

- **Custom instructions** (if available):  
  *"When I say 'analyze', 'commit', 'push', 'stage', or 'add', read and follow the instructions in `~/repos/ai-workbench/skills/git-workflow/SKILL.md`. Use that file for git workflow only."*  
  Adjust the path if your repo is elsewhere, or use **`~/.cursor/skills/git-workflow/SKILL.md`** if you installed the global skill.

- **First message in a dedicated git conversation**:  
  *"My git workflow is at `~/repos/ai-workbench/skills/git-workflow/SKILL.md`. For this conversation, when I say 'analyze', 'commit', 'push', or 'stage', read that file and follow it. Don't paste it here—load it by path."*

The agent uses its file/read capability to load the file; you only send the path.

### Two-window pattern: separate git agent (saves context)

People often run **two agent windows**: one for thinking/coding (full codebase and long thread), one only for git. The git agent stays small—workflow + your "analyze"/"commit"/"push"—so it doesn't eat context in your main agent.

**Cursor**

1. Open a **second Agent chat** (new chat in the panel, or a second Cursor window on the same repo).
2. In that chat, invoke by **name**: **/git-workflow** (global skill) or **@git-workflow** (in this repo). No pasting—the skill/rule is loaded by name.
3. Use this chat **only** for: "analyze", "commit", "push", "stage …".
4. Main chat stays for coding; switch to the git chat when you want to commit or push.

**Claude Code (or Claude in browser)**

1. Open a **second conversation** (new chat / new window or tab) as your "git agent."
2. In the first message, **reference by path**—do not paste the file:  
   *"My git workflow is at `~/repos/ai-workbench/skills/git-workflow/SKILL.md`. For this conversation, when I say 'analyze', 'commit', 'push', or 'stage', read that file and follow it. I'm only going to ask you for git workflow in this chat."*
3. Then say "analyze", "commit", "push", or "stage …" as needed. The agent reads the file from that path. If it can run terminal commands in your project, it runs the git commands; otherwise it outputs the exact commands for you.
4. Use your other conversation for coding; this one stays small (path + your short commands).
