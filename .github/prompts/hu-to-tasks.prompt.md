---
description: Hydrate Jira child tasks with scope, files to edit, acceptance criteria, and Definition of Ready (DoR).
---

# Hydrate Jira Child Tasks (hu-to-tasks)

Transform a child task that currently only has a title in Jira into a fully hydrated technical task card.

## For Each Child Task:
1. Identify the target repository and technology layer (`BE Java/Kotlin`, `FE Angular`, `Mobile Android`, `Mobile iOS`, `Batch`).
2. Extract the specific Given/When/Then acceptance criteria assigned to this task from `spec.md`.
3. List the exact files to create or modify in `@workspace`.
4. Validate the **Definition of Ready (DoR)**:
   - Contract finalized in `contract.md`?
   - Cero criteria in `HIPOTESIS` for this layer?
5. Generate the copy-paste markdown block for Jira Enterprise.

Output to `work/<HU-KEY>-<slug>/task-cards/<TASK-KEY>.md`.
