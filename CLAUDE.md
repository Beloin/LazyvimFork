# CLAUDE.md

This repository is a personal Neovim configuration built on top of LazyVim.

## Project Shape

- `init.lua` bootstraps the config.
- `lua/config/` contains core setup such as lazy loading, options, keymaps, and autocmds.
- `lua/plugins/` contains plugin specs and plugin-specific configuration overrides.
- `lua/utils/` contains local helper modules.
- `lua/external/` contains external or more isolated setup modules.
- `test/` contains small Lua test/debug helpers.
- `lazy-lock.json` pins plugin versions.

## Working Rules

- Keep changes minimal and local to the requested area.
- Do not rewrite unrelated plugin specs or formatting.
- Preserve the existing Lua style: 2-space indentation and max line width 120, matching `stylua.toml`.
- Prefer extending existing files in `lua/plugins/` over creating new modules unless separation is clearly useful.
- Avoid changing `lazy-lock.json` unless the task explicitly involves plugin updates.
- The worktree may already be dirty. Do not revert unrelated user changes.

## Plugin Conventions

- Plugin definitions are managed through `lazy.nvim` in `lua/config/lazy.lua`.
- Custom plugin specs are loaded from `{ import = "plugins" }`, so files under `lua/plugins/` should return valid lazy spec tables.
- LazyVim extras are enabled in `lua/config/lazy.lua`; prefer reusing those patterns instead of replacing them wholesale.

## Validation

Use the lightest check that fits the change:

- Format Lua files with `stylua`.
- Start Neovim headlessly to catch load errors:
  - `nvim --headless "+qa"`
- For LSP-related debugging, inspect `test/lsp_test.lua`.

## Notes For Future Edits

- `README.md` is lightweight and partly aspirational. Prefer reading the actual Lua files before making structural assumptions.
- This repo appears to be used interactively as a personal setup, so favor practical edits over broad refactors.
