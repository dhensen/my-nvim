local default_opts = { noremap = true, silent = true }
local wk = require "which-key"
require("trouble").setup {}

local function opts(desc)
    return vim.tbl_extend("force", default_opts, { desc = desc })
end

wk.add {
    { "<leader>b", group = "Buffers" },
    { "<leader>c", group = "Code / Clipboard / Coverage" },
    { "<leader>f", group = "Find / Format" },
    { "<leader>g", group = "Git" },
    { "<leader>i", group = "Diagnostics" },
    { "<leader>l", group = "Line Numbers" },
    { "<leader>r", group = "Run / Refactor" },
    { "<leader>S", group = "Search & Replace (grug-far)" },
    { "<leader>w", group = "Workspace" },
    { "<leader>x", group = "Trouble" },
    { "<leader>.", desc = "Scratch Buffer" },
}

vim.keymap.set("", "<Space>", "<Nop>", default_opts)

-- Mappings.
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", opts "Toggle File Tree")
vim.keymap.set("n", "<leader>j", ":NvimTreeFindFile<CR>", opts "Find Current File in Tree")

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>a", vim.diagnostic.open_float, opts "Open Diagnostic Float")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts "Previous Diagnostic")
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts "Next Diagnostic")
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts "Diagnostics to Location List")

vim.keymap.set("x", "<leader>p", '"_d"+P', { desc = "Paste Over Selection Before" })
vim.keymap.set("x", "<leader>P", '"_d"+p', { desc = "Paste Over Selection After" })

vim.keymap.set("n", "<leader>cp", '"+p', { desc = "Paste from System Clipboard After" })
vim.keymap.set("n", "<leader>cP", '"+P', { desc = "Paste from System Clipboard Before" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank Line to System Clipboard" })

vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete to Black Hole Register" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete to Black Hole Register" })

-- this prevents from going into Ex mode
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex Mode" })

vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts "Clear Search Highlight")

-- Resizing panes
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", opts "Increase Window Width")
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", opts "Decrease Window Width")
vim.keymap.set("n", "<Up>", ":resize -1<CR>", opts "Decrease Window Height")
vim.keymap.set("n", "<Down>", ":resize +1<CR>", opts "Increase Window Height")

vim.keymap.set("n", "<leader>e", ":RunFile<CR>", opts "Run File")

-- Better indent: stay in visual mode after changing indent
vim.keymap.set("v", "<", "<gv", opts "Indent Left")
vim.keymap.set("v", ">", ">gv", opts "Indent Right")

-- Better escape using jk in insert and terminal mode
vim.keymap.set("i", "jk", "<ESC>", opts "Exit Insert Mode")
vim.keymap.set("t", "jk", "<C-\\><C-n>", opts "Exit Terminal Mode")

-- Move selected line / block of text in visual mode
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts "Move Selection Up")
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts "Move Selection Down")

-- grug-far: open with visual selection pre-filled
vim.keymap.set("v", "<leader>Sv", function()
    require("grug-far").with_visual_selection()
end, { desc = "Search visual selection (grug-far)" })

local builtin = require "telescope.builtin"

vim.keymap.set("n", "<C-p>", function()
    builtin.git_files { search_untracked = true }
end, { desc = "telescope git_files with show untracked" })

vim.keymap.set("n", "<leader>ln", function()
    if vim.wo.relativenumber then
        vim.wo.relativenumber = false
        vim.wo.number = true
    else
        vim.wo.relativenumber = true
        vim.wo.number = true
    end
end, { desc = "Toggle relative line numbers" })

wk.add {
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
    { "<leader>ga", "<cmd>Git add -p<CR>", desc = "Add -p" },
    { "<leader>gb", "<cmd>Git blame<CR>", desc = "Blame" },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "Commit" },
    { "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Hunk" },
    { "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
    {
        "<leader>gl",
        "<cmd>GlLog<CR>",
        desc = "Load all previous revisions into quicklist",
    },
    { "<leader>gp", "<cmd>Git push<CR>", desc = "Push" },
    { "<leader>gs", "<cmd>Git<CR>", desc = "Open Fugitive" },
    {
        "<leader>gg",
        function()
            Snacks.lazygit()
        end,
        desc = "LazyGit",
    },
    {
        "<leader>gB",
        function()
            Snacks.gitbrowse()
        end,
        desc = "Open in Browser",
    },
    { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "UndotreeToggle" },
    {
        "<leader>R",
        "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP Definitions / references / ... (Trouble)",
    },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
    {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Buffer Diagnostics (Trouble)",
    },
    {
        "<leader>xd",
        "<cmd>Trouble diagnostics toggle<CR>",
        desc = "Trouble Toggle Document Diagnostics",
    },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Quickfix (Trouble)" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
    { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle ZenMode" },
    {
        "<leader>bd",
        function()
            Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
    },
    {
        "<leader>.",
        function()
            Snacks.scratch()
        end,
        desc = "Scratch Buffer",
    },
    {
        "<leader>So",
        function()
            require("grug-far").open()
        end,
        desc = "Open",
    },
    {
        "<leader>Sw",
        function()
            require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } }
        end,
        desc = "Search word under cursor",
    },
    {
        "<leader>Sf",
        function()
            require("grug-far").open { prefills = { paths = vim.fn.expand "%" } }
        end,
        desc = "Search in current file",
    },
}
