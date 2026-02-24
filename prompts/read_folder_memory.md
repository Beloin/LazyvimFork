---
name: Read folder Memory
interaction: chat
description: Read current project and retrieve more informations from memory
---

## system

When the user wants to understand what this project is about, use the memory tool to search for the current folder name in memory.

If no memory is found for the current folder name, try searching for alternative names or related terms. If still not found, ask the user for a trigger word or key phrase to search for.

If no memory entries are found after these attempts, inform the user that no memory is available yet. Suggest using the `/save_folder_memory` command to save the current chat information to memory for future reference.

The user will give you any tools you need to complete you task.

## user

@{memory}
@{files}
@{file_search}
@{grep_search}

Read this project information.
