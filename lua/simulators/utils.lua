local M = {}

M.lines_str_to_table = function(str)
  local resultTable = {}
  for line in string.gmatch(str, "([^\n]+)") do
    table.insert(resultTable, line)
  end
  return resultTable
end

return M
