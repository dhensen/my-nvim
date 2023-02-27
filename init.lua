require "plugins"
require "keybindings"
require "options"

-- prevent netrw from loading because I will use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

require('nvim-treesitter.configs').setup {
    ensure_installed = { "help", "python", "javascript", "lua", "typescript", "go", "rust", "c", "php" },
    sync_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false, },
    indent = { enable = true }
}

require('lualine').setup({
    options = {
        -- theme = 'palenight'
        theme = 'auto'
    }
})

require 'autocomplete'
require 'nullls'
require 'testing'
require 'harpon'
require 'fugitive'

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)


vim.g.python3_host_prog = "/home/dino/.nvim-venv/bin/python3"

function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    -- enable these if you want transparent bg:
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
