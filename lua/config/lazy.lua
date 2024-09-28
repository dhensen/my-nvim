-- plugins.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins using lazy.nvim
require("lazy").setup {

    -- Plugin list
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require "nvim-treesitter.configs"

            configs.setup {
                ensure_installed = {
                    "vimdoc",
                    "python",
                    "javascript",
                    "lua",
                    "typescript",
                    "go",
                    "rust",
                    "c",
                    "php",
                    "terraform",
                    "comment",
                },
                sync_install = false,
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                indent = { enable = true },
                -- context_commentstring nvim-treesitter module is deprecated, use require('ts_context_commentstring').setup {} and set vim.g.skip_ts_context_commentstring_module = true to speed up loading instead.
                -- This feature will be removed in ts_context_commentstring version in the future (see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82 for more info)
                -- context_commentstring = {
                --     enable = true,
                --     enable_autocmd = false,
                -- },
            }
        end,
    },

    { "ellisonleao/gruvbox.nvim" },

    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },

    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
    },

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
    },

    { "theprimeagen/harpoon" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },

    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("Comment").setup {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup {}
        end,
    },

    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup {
                auto_restore = false,
                log_level = "error",
                suppressed_dirs = { "~/", "~/Downloads", "~/work", "/" },
            }
        end,
    },

    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
    },

    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.theta").config)
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup {
                indent = {
                    char = "▏",
                    tab_char = "▏",
                },
            }
        end,
    },

    {
        "CRAG666/code_runner.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("code_runner").setup()
        end,
    },

    {
        "tamton-aquib/duck.nvim",
        config = function()
            vim.keymap.set("n", "<leader>dd", function()
                require("duck").hatch()
            end, {})
            vim.keymap.set("n", "<leader>dk", function()
                require("duck").cook()
            end, {})
        end,
    },

    { "rebelot/kanagawa.nvim" },

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },

    {
        "yorickpeterse/nvim-pqf",
        config = function()
            require("pqf").setup()
        end,
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {}
        end,
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "wintermute-cell/gitignore.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },

    { "mfussenegger/nvim-dap" },
    { "jay-babu/mason-nvim-dap.nvim" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
    },

    { "github/copilot.vim" },

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup {
                size = function(term)
                    if term.direction == "horizontal" then
                        return 20
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    end
                end,
                start_in_insert = false,
                on_open = function()
                    vim.keymap.set("n", "<C-q>", "<cmd>close<CR>", { buffer = true, noremap = true, silent = true })
                    vim.keymap.set(
                        "t",
                        "<C-q>",
                        "<C-\\><C-n><cmd>close<CR><C-w><C-p>",
                        { buffer = true, noremap = true, silent = true }
                    )
                    vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { buffer = true, noremap = true, silent = true })
                    vim.wo.cursorcolumn = false
                    vim.wo.cursorline = false
                    vim.cmd "wincmd="
                end,
                highlights = {
                    Normal = {
                        link = "NormalFloat",
                    },
                    NormalFloat = {
                        link = "NormalFloat",
                    },
                    FloatBorder = {
                        link = "FloatBorder",
                    },
                },
                float_opts = {
                    border = { " ", " ", " ", " ", " ", " ", " ", " " },
                    winblend = 0,
                    width = vim.o.columns - 20,
                    height = vim.o.lines - 9,
                    highlights = {
                        border = "FloatBorder",
                        background = "NormalFloat",
                    },
                },
            }
        end,
    },
}
