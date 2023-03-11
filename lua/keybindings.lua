
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
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, default_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, default_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, default_opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, default_opts)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("x", "<leader>P", "\"_d\"+P")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- this prevents from going into Ex mode
vim.keymap.set("n", "Q", "<nop>")

keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Better indent: stay in visual mode after changing indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)
