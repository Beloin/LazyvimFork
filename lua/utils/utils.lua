--- utils.lua
local M = {}

local function mysplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

function M.run_sh(command)
	local handle = io.popen(command)
	if not handle then
		return false, nil
	end

	local result = handle:read("*a")
	handle:close()

	return true, result
end

function M.tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

M.str_split = mysplit

return M
