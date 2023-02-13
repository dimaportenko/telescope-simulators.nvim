local utils = require('simulators.utils')

local M = {}

M.get_available = function()
  local cmd = "emulator -list-avds"
  local result = vim.fn.system(cmd)


  local names = utils.lines_str_to_table(result)
  -- map list of strings to objects with name and osVersion
  local devices = vim.tbl_map(function(entry)
    return {
      name = entry,
      osVersion = "Android",
    }
  end, names)

  return devices
end

M.run = function(name)
  local cmd = "emulator -avd " .. name
  vim.fn.system(cmd)
end

return M
