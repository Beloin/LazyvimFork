--- cmd.lua
local M = {}

--- Run command in shell return status and result
---@param command string
---@return boolean, string?
function M.run(command)
  local handle = io.popen(command)
  if not handle then
    return false, nil
  end

  local result = handle:read("*a")
  handle:close()

  return true, result
end

return M
