return {
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
}
