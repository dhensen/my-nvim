local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.yapf,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.mypy,
    },
    temp_dir = '/tmp/null-ls'
})

