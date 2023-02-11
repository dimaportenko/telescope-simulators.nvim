local telescope = require "telescope"
local run = require("simulators").run

return telescope.register_extension {
  exports = {
    run = run,
  }
}
