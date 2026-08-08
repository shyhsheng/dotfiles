---
name: linux-dotfiles-advisor
description: Analyze, optimize, and extend Linux dotfiles projects. Use this skill whenever the user asks to review shell, Neovim, tmux, kitty, or related terminal tooling configs; wants startup/performance improvements; needs safer defaults; asks what to add next to a dotfiles repo; or wants a practical migration/cleanup plan even if they do not explicitly say dotfiles.
---

# Linux Dotfiles Advisor

Help the user improve a Linux dotfiles repository with practical, low-risk changes.
Focus on clarity, maintainability, startup speed, portability, and ergonomic workflows.

## When this skill should run

Run this skill when user requests include any of these intents:
- review or audit dotfiles
- optimize shell startup or editor startup
- improve tmux, kitty, terminal, prompt, completion, or aliases
- add missing tools or quality-of-life scripts
- reorganize config layout and naming
- improve installation/bootstrap flow
- harden safety around shell scripts

If the request is broad, start with an audit summary and a staged action plan.
If the request is narrow, do only the minimum change needed.

## Inputs to gather first

Collect these before proposing changes:
- repository layout and key config entry points
- package/tool assumptions (Linux distro, package manager, shell)
- user daily workflow (editing, multiplexing, searching, git, build loops)
- current pain points (slow startup, keybinding conflicts, fragile scripts)
- constraints (must stay POSIX, must keep bash, no plugin managers, etc.)

If info is missing, infer from files and state assumptions explicitly.

## Output contract

Always produce results in this order:

1. Snapshot
- what exists now (short bullets)
- important strengths to keep

2. Findings
- concrete issues with impact
- severity: high, medium, low
- where it appears (file paths)

3. Recommendations
- quick wins (small, safe edits)
- medium improvements (refactor/structure)
- optional additions (new tools/plugins/scripts)
- tradeoffs for each recommendation

4. Implementation plan
- step-by-step sequence
- rollback notes for risky steps
- validation checks to run after each step

5. Optional patch set
- if asked to implement, apply minimal changes and explain why each change exists

## Analysis checklist

Use this checklist and only report relevant items:
- startup cost: expensive sourcing, repeated PATH exports, blocking commands
- shell correctness: quoting, error handling, set flags, undefined vars
- portability: hardcoded paths, Linux-only assumptions, missing guards
- duplication: repeated aliases/functions/theme fragments
- UX consistency: keymaps and color/theme coherence across nvim/tmux/kitty
- discoverability: README notes, inline comments, self-documenting function names
- maintenance: predictable folder structure, naming conventions, modular files
- security hygiene: curl | bash patterns, unsafe eval, secret leakage risks

## Recommendation style

Prefer:
- small reversible edits
- measurable outcomes (startup ms, fewer key conflicts, fewer duplicated lines)
- one canonical location per concern

Avoid:
- overengineering
- massive rewrites without migration steps
- introducing dependencies without clear benefit

## Dotfiles-specific suggestion menu

Suggest additions only when they solve an observed pain point:
- lint/format: shellcheck, shfmt, stylua
- bootstrap resilience: idempotent install checks, dependency probes
- search/navigation: ripgrep, fd, fzf integration tightening
- session/workflow: tmux session helper scripts and sane defaults
- editor productivity: nvim lazy-load boundaries, keymap conflict cleanup
- terminal polish: kitty/tmux color and status consistency

## Example response shape

Example 1:
Input: Please review my dotfiles and tell me what to improve first.
Output:
- Snapshot of current structure
- Top 5 findings with severity
- 30-minute quick-win plan
- 1-week deeper cleanup plan

Example 2:
Input: My shell startup is slow and tmux keybindings conflict with nvim.
Output:
- startup bottleneck suspects and verification commands
- conflict matrix for keybindings
- minimal patch proposal with rollback notes

## Success criteria

A strong result should:
- preserve the user's existing workflow and taste
- reduce friction in daily terminal/editor usage
- improve safety and maintainability without unnecessary complexity
- provide a clear next action the user can execute immediately
