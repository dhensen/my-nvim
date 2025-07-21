return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup {
            stages = "static",
            top_down = false,
            timeout = 3000,
        }

        vim.notify = require "notify"
    end,
}
