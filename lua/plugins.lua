-- copied from https://github.com/wbthomason/packer.nvim
--
local download_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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

return require('packer').startup(function(use)
    -- use "nvim-lua/plenary.nvim" -- I installed this when installing null-ls
    use 'wbthomason/packer.nvim'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons'
        }
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use { "ellisonleao/gruvbox.nvim" }
    use { 'neovim/nvim-lspconfig' } -- Configurations for Nvim LSP

    use { 'hrsh7th/nvim-cmp' } -- Autocompletion plugin
    use { 'hrsh7th/cmp-nvim-lsp' }  -- LSP source for nvim-cmp
    use { 'saadparwaiz1/cmp_luasnip' } -- Snippets source for nvim-cmp
    use { 'L3MON4D3/LuaSnip' } -- Snippets plugin
    use { 'jose-elias-alvarez/null-ls.nvim', requires = { "nvim-lua/plenary.nvim" } } -- null-ls

    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python"
        }
    }
    --use({
    --    "rebelot/heirline.nvim",
    --    -- You can optionally lazy-load heirline on UiEnter
    --    -- to make sure all required plugins and colorschemes are loaded before setup
    --    -- event = "UiEnter",
    --    config = function()
    --        require("heirline").setup()
    --    end
    --})
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require("rose-pine").setup({
                dark_variant = 'moon',
            })
            --vim.cmd('colorscheme rose-pine')
            --this is done in ColorMyPencils, because this func runs secondly and undos the Normal bg=none
        end
    })

    use { 'theprimeagen/harpoon' }
    use { 'mbbill/undotree' }
    use { 'tpope/vim-fugitive' }

    if packer_bootstrap then
    auto_install = true,
        require('packer').sync()
    end
end)
