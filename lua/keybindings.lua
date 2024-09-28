local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local wk = require "which-key"

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })


-- Mappings.
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", default_opts)
keymap("n", "<leader>j", ":NvimTreeFindFile<CR>", default_opts)

keymap("n", "<C-H>", "<C-w><C-H>", default_opts)
keymap("n", "<C-J>", "<C-w><C-J>", default_opts)
keymap("n", "<C-K>", "<C-w><C-K>", default_opts)
keymap("n", "<C-L>", "<C-w><C-L>", default_opts)

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>a", vim.diagnostic.open_float, default_opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, default_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, default_opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, default_opts)

vim.keymap.set("x", "<leader>p", '"_d"+P')
vim.keymap.set("x", "<leader>P", '"_d"+P')

vim.keymap.set("n", "<leader>cp", '"+p')
vim.keymap.set("n", "<leader>cP", '"+P')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- this prevents from going into Ex mode
vim.keymap.set("n", "Q", "<nop>")

keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

keymap("n", "<leader>e", ":RunFile<CR>", default_opts)

-- Better indent: stay in visual mode after changing indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

vim.keymap.set("n", "<leader>xx", function()
    require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
    require("trouble").toggle "workspace_diagnostics"
end)
vim.keymap.set("n", "<leader>xd", function()
    require("trouble").toggle "document_diagnostics"
end)
vim.keymap.set("n", "<leader>xq", function()
    require("trouble").toggle "quickfix"
end)
vim.keymap.set("n", "<leader>xl", function()
    require("trouble").toggle "loclist"
end)
vim.keymap.set("n", "gR", function()
    require("trouble").toggle "lsp_references"
end)

vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

local builtin = require "telescope.builtin"

vim.keymap.set("n", "<C-p>", function()
    builtin.git_files { search_untracked = true }
end, { desc = "telescope git_files with show untracked" })

wk.add {
    { "<leader>f", group = "Telescope" },
    { "<leader>fb", builtin.buffers, desc = "Buffers" },
    { "<leader>ff", builtin.find_files, desc = "Find Files" },
    { "<leader>fg", builtin.live_grep, desc = "Live Grep" },
    { "<leader>fh", builtin.help_tags, desc = "Help Tags" },
    { "<leader>fk", builtin.keymaps, desc = "Keymaps" },
    {
        "<leader>fs",
        function()
            builtin.grep_string { search = vim.fn.input "Grep > " }
        end,
        desc = "Grep String with custom input",
    },
    { "<leader>fw", builtin.grep_string, desc = "Grep String" },
    { "<leader>g", group = "Git" },
    { "<leader>ga", "<cmd>Git add -p<CR>", desc = "Add -p" },
    { "<leader>gb", "<cmd>Git blame<CR>", desc = "Blame" },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "Commit" },
    { "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Hunk" },
    { "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
    { "<leader>gl", "<cmd>GlLog<CR>", desc = "Load all previous revisions into quicklist" },
    { "<leader>gp", "<cmd>Git push<CR>", desc = "Push" },
    { "<leader>gs", "<cmd>Git<CR>", desc = "Open Fugitive" },
    { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "UndotreeToggle" },
}
