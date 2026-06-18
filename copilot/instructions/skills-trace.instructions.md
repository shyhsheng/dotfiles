---
name: "Skills Trace Footer"
description: "Use when responding to coding, debugging, review, or implementation tasks. Ensure each substantial response ends with a concise one-line Used workflow/skills trace for observability across sessions."
---
# Skills Trace Footer

- For substantial responses, append one final line:
  Used workflow/skills: <skill/workflow names>
- Keep the trace concise and practical.
- Only list user-installed extra skills.
- Do not list built-in skills, internal workflow labels, or system prompt names.
- Do not include chain-of-thought or internal hidden reasoning.
- If the user explicitly requests a specific user-installed extra skill by name and it is used, always include that skill in the trace.
- If no user-installed extra skill is used, omit the trace line.
- For very short casual chat replies, the trace may be omitted.
