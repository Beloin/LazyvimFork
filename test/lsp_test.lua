-- for _, client in pairs(vim.lsp.get_active_clients()) do
--   print(client.name)
-- end

for _, client in pairs(vim.lsp.get_clients()) do
  print(client.name)
end
