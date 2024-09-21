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

local function namespace_name(name)
  local new_name = (name:gsub("^%l", string.upper))
  -- new_name = (new_name:gsub("_", ""))
  -- return new_name
  local result_str = ""
  local shouldup = false
  for c = 1, #new_name do
    local char = (new_name:sub(c, c))
    if char == "_" then
      shouldup = true
      goto continue
    elseif shouldup then
      char = string.upper(char)
      shouldup = false
    end
    result_str = result_str .. char
      ::continue::
  end

  return result_str
end

local function guard_name(config)
  local fullfile = config.filename
  local cwd = vim.fn.getcwd()
  local result = (fullfile:gsub(cwd, ""))
  result = (result:sub(2, #result))
  result = (result:gsub("/", "_"))
  result = (result:gsub("%.(.*)", ""))
  return string.upper(result) .. "_H"
end

local function folder_namespace(config)
  local fullname = config.filename
  local folderlist = mysplit(fullname, "/")
  local folder = folderlist[#folderlist - 1]
  return "namespace " .. namespace_name(folder) .. " {"
end

local function end_folder_namespace(config)
  return "}"
end

local function folder_name(config)
  local fullname = config.filename
  local folderlist = mysplit(fullname, "/")
  local folder = folderlist[#folderlist - 1]
  return folder
end

M.folder_namespace = folder_namespace
M.end_folder_namespace = end_folder_namespace
M.guard_name = guard_name
M.folder_name = folder_name

return M
