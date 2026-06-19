return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function(_, opts)
        local fzf = require "fzf-lua"
        fzf.setup(opts)
        fzf.register_ui_select()
    end,
}
