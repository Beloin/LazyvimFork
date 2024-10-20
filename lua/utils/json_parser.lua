--- json_parser.lua
local M = {}

--- Parse JSON into Table
---@param str string
---@return table
local function parse(str)
  return vim.json.decode(str)
end

M.parse = parse

return M
