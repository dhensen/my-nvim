-- copied from https://github.com/wbthomason/packer.nvim
--
local download_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = download_packer()

-- this part copied from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/first_load.lua
-- return function()
--     if not pcall(require, "packer") then
--         download_packer()
--
--         return true
--     end
--
--     return false
-- end

return require("packer").startup(function(use)
    -- use "nvim-lua/plenary.nvim" -- I installed this when installing null-ls
    use "wbthomason/packer.nvim"
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update { with_sync = true }
        end,
    }
    use { "ellisonleao/gruvbox.nvim" }
    use { "neovim/nvim-lspconfig" } -- Configurations for Nvim LSP

    use { "hrsh7th/nvim-cmp" } -- Autocompletion plugin
    use { "hrsh7th/cmp-nvim-lsp" } -- LSP source for nvim-cmp
    use { "hrsh7th/cmp-path" } -- LSP source for nvim-cmp
    use { "saadparwaiz1/cmp_luasnip" } -- Snippets source for nvim-cmp
    use { "L3MON4D3/LuaSnip" } -- Snippets plugin
    use { "nvimtools/none-ls.nvim", requires = { "nvim-lua/plenary.nvim" } } -- null-ls

    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
        },
    }
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        -- or                            , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } },
    }
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    }

    use {
        "rose-pine/neovim",
        as = "rose-pine",
    }

    use { "theprimeagen/harpoon" }
    use { "mbbill/undotree" }
    use { "tpope/vim-fugitive" }
    use {
        "numToStr/Comment.nvim",
        requires = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("Comment").setup {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    }
    use {
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    }
    use {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_restore_enabled = false,
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "~/work", "/" },
            }
        end,
    }
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    }
    use {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.theta").config) -- TODO copy this theme and customize
        end,
    }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    }

    use { "williamboman/mason.nvim" }
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end,
    }

    use {
        "CRAG666/code_runner.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("code_runner").setup()
        end,
    }

    use {
        "tamton-aquib/duck.nvim",
        config = function()
            vim.keymap.set("n", "<leader>dd", function()
                require("duck").hatch()
            end, {})
            vim.keymap.set("n", "<leader>dk", function()
                require("duck").cook()
            end, {})
        end,
    }

    use "rebelot/kanagawa.nvim"
    use { "kevinhwang91/nvim-bqf", ft = "qf" }

    use {
        "yorickpeterse/nvim-pqf",
        config = function()
            require("pqf").setup()
        end,
    }

    use {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    }

    use {
        "folke/trouble.nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
    }

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    }

    use {
        "wintermute-cell/gitignore.nvim",
        requires = {
            "nvim-telescope/telescope.nvim",
        },
    }

    use { "mfussenegger/nvim-dap" }
    use { "jay-babu/mason-nvim-dap.nvim" }
    use {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)
