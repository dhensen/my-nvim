
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }


vim.g.mapleader = ","

-- Mappings.
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", default_opts)

keymap("n", "<C-H>", "<C-w><C-H>", default_opts)
keymap("n", "<C-J>", "<C-w><C-J>", default_opts)
keymap("n", "<C-K>", "<C-w><C-K>", default_opts)
keymap("n", "<C-L>", "<C-w><C-L>", default_opts)

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, defaultopts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, defaultopts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, defaultopts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, defaultopts)

