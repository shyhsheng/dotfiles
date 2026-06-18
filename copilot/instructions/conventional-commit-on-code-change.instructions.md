---
name: "Conventional Commit On Code Change"
description: "Use when adding, modifying, refactoring, or fixing code in any project. Always provide Conventional Commit message suggestions whenever code changes are introduced."
applyTo: "**"
---
# Conventional Commit Requirement

When code is added or modified, always include at least one suggested commit message in the response.
If no code is changed, do not include commit message suggestions.

## Required format

Use Conventional Commits format:

```
<type>(<optional-scope>): <description>
[body]

[optional footer(s)]
```

## Preferred types

Use one of these types when possible:
- `feat`
- `fix`
- `refactor`
- `perf`
- `docs`
- `test`
- `chore`

## Quality rules

- Keep type and scope lowercase.
- Keep subject concise and action-oriented.
- Use a scope that matches the changed area.
- If there are multiple independent logical changes, suggest one commit message per logical change.

## Examples

- `feat(auth): add refresh token rotation`
- `fix(api): handle null payload in webhook parser`
- `refactor(core): split config loader into modules`
- `chore(ci): standardize lint workflow steps`
