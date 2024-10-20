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

M.get_type = function()
  local filename = vim.fn.expand("%:t")

  if filename:sub(1, 1) == "I" then
    return "interface"
  else
    return "class"
  end
end

local function find_csproj_dir_recursive(dir, dirs_traversed)
  local current_dir_name = vim.fn.fnamemodify(dir, ":t")
  table.insert(dirs_traversed, current_dir_name)

  local csproj = vim.fn.glob(dir .. "/*.csproj")

  if csproj ~= "" then
    return dir
  end

  if dir == "/" or dir:match("^%a:[\\/]*$") then
    return nil
  end

  local parent_dir = vim.fn.fnamemodify(dir, ":h")
  return find_csproj_dir_recursive(parent_dir, dirs_traversed)
end

local function reverse_table(t)
  local reversed = {}
  for i = #t, 1, -1 do
    table.insert(reversed, t[i])
  end
  return reversed
end

M.get_cs_namespace = function()
  local current_dir = vim.fn.expand("%:p:h")

  local dirs_traversed = {}

  local csproj_dir = find_csproj_dir_recursive(current_dir, dirs_traversed)
  if not csproj_dir then
    return "NamespaceNotFound"
  end

  local reversed = reverse_table(dirs_traversed)

  return table.concat(reversed, ".")
end

M.get_classname = function()
  return vim.fn.expand("%:t:r")
end

M.folder_namespace = folder_namespace
M.end_folder_namespace = end_folder_namespace
M.guard_name = guard_name
M.folder_name = folder_name

return M
