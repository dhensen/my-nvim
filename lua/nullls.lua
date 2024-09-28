local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local tmp_dir = "/tmp/null-ls"
local navic = require "nvim-navic"
navic.setup()
vim.fn.mkdir(tmp_dir, "p")
null_ls.setup {
    sources = {
        require("none-ls.diagnostics.ruff"),
        -- null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.yapf,
    },
    temp_dir = tmp_dir,
    on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format {
                        bufnr = bufnr,
                        filter = function(client_)
                            return client_.name == "null-ls"
                        end,
                    }
                end,
            })
        end
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, ev.buf)
        end
    end,
}
