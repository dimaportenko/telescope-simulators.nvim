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
  local job_id = vim.fn.jobstart(cmd, { -- using jobstart here as .system blocks my input
      detach = true,
  })

  if job_id <= 0 then
      vim.notify("Failed to start " .. name, vim.log.levels.ERROR)
  else
      vim.notify("Started " .. name, vim.log.levels.INFO)
  end
end

return M
