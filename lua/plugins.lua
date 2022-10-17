local packer_bootstrap = require "ensure_packer"()
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons'
        }
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
