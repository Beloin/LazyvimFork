local utils = require "utils.utils"
--- java_finder.lua
local M = {}


local function finder(workspace)
  local cmd = 'find . -name "*.java" -exec grep "void main\" {} +'
  local ok, result = utils.run_sh(cmd)
  if not ok then
    return false, ''
  end

  local split = utils.str_split(result, ':')
  local filename = split[1]

  return true, filename
end

M.finder = finder

return M
