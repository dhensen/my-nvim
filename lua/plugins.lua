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

    if packer_bootstrap then
        require('packer').sync()
    end
end)
