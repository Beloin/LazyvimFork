--- langs.lua
local M = {}

function M.findCurrentLangName()
  return vim.bo.filetype
end

return M
