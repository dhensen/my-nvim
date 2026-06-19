return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            PATH = "append",
        }
        require("mason-lspconfig").setup { automatic_installation = true }
        require("mason-nvim-dap").setup {
            ensure_installed = { "python" },
        }
    end,
}
