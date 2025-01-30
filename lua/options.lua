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
-- opt.colorcolumn = "100"

-- ignorecase by default, then add smartcase
-- as soon as you start adding capital case chars, it will switch so case sensitive
opt.ignorecase = true
opt.smartcase = true

-- opt.winbar = "%=%m %f"
-- opt.winbar = "%=%m %{%v:lua.vim.fn.expand('%F')%} %{%v:lua.require'nvim-navic'.get_location()%}"

vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")

        -- Example: Ignore winbar for terminal, help, and NvimTree buffers
        if buftype == "terminal" or filetype == "help" or filetype == "NvimTree" then
            vim.opt_local.winbar = nil
        else
            -- Set your desired winbar value here for other buffers
            -- vim.opt_local.winbar = "%=%m %f"
            vim.opt_local.winbar = "%=%m %{%v:lua.vim.fn.expand('%F')%} %{%v:lua.require'nvim-navic'.get_location()%}"
        end
    end,
})
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        if vim.bo.filetype == "toggleterm" then
            vim.opt_local.winbar = nil
        end
    end,
})

opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal,localoptions"
