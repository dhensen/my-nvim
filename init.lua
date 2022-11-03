
require "plugins"
require "keybindings"
require "options"

-- prevent netrw from loading because I will use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = true }
}

require('autocomplete')
