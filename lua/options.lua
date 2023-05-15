--keybindings

local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.hidden = true -- keep buffers around but hidden
opt.splitright = true
opt.number = true
opt.relativenumber = true
opt.guicursor = ""

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv "HOME" .. "/.config/nvim/undodir"
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true
opt.scrolloff = 8

opt.signcolumn = "auto"

opt.updatetime = 50
opt.colorcolumn = "100"

-- ignorecase by default, then add smartcase
-- as soon as you start adding capital case chars, it will switch so case sensitive
opt.ignorecase = true
opt.smartcase = true
