
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }


vim.g.mapleader = ","

keymap("n", "<leader>n", ":NvimTreeToggle<CR>", default_opts)

keymap("n", "<C-H>", "<C-w><C-H>", default_opts)
keymap("n", "<C-J>", "<C-w><C-J>", default_opts)
keymap("n", "<C-K>", "<C-w><C-K>", default_opts)
keymap("n", "<C-L>", "<C-w><C-L>", default_opts)
