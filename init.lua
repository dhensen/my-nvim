require "plugins"
require "keybindings"
require "options"

-- prevent netrw from loading because I will use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "NvimTree*",
    callback = function()
        local api = require "nvim-tree.api"
        local view = require "nvim-tree.view"

        if not view.is_visible() then
            api.tree.open()
        end
    end,
})

-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

require("nvim-treesitter.configs").setup {
    ensure_installed = { "vimdoc", "python", "javascript", "lua", "typescript", "go", "rust", "c", "php" },
    sync_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}

require("lualine").setup {
    options = {
        icons_enabled = true,
        -- theme = 'palenight'
        theme = "auto",
    },
}

require "autocomplete"
require "nullls"
require "testing"
require "harpon"
require "fugitive"

vim.g.python3_host_prog = os.getenv "HOME" .. "/.nvim-venv/bin/python3"

function ColorMyPencils(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    -- enable these if you want transparent bg:
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}

-- hide tilde for empty lines
vim.cmd [[hi NonText guifg=bg]]
