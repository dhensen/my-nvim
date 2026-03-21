return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- replaces nvim-notify
        notifier = {
            enabled = true,
            timeout = 3000,
            top_down = false,
            style = "fancy",
        },
        -- replaces indent-blankline (was disabled, now properly enabled)
        indent = {
            enabled = true,
            indent = { char = "▏" },
            scope = { char = "▏", underline = true },
        },
        -- highlight all occurrences of word under cursor
        words = { enabled = true },
        -- better sign + fold column
        statuscolumn = { enabled = true },
        -- smooth scrolling
        scroll = { enabled = true },
        -- faster startup when opening a file directly
        quickfile = { enabled = true },
        -- lazygit float
        lazygit = { enabled = true },
        -- open current file/line/selection in GitHub/GitLab/etc
        gitbrowse = { enabled = true },
        -- close buffer without closing the window
        bufdelete = { enabled = true },
        -- scratch buffers
        scratch = { enabled = true },
        -- disabled: already covered by other plugins
        bigfile    = { enabled = false }, -- large-files.lua
        dashboard  = { enabled = false }, -- alpha-nvim
        explorer   = { enabled = false }, -- nvim-tree
        input      = { enabled = false }, -- dressing.nvim
        terminal   = { enabled = false }, -- toggleterm
        zen        = { enabled = false }, -- zen-mode.nvim
        picker     = { enabled = false }, -- telescope + fzf-lua
    },
}
