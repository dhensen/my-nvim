-- thanks to ret2src: https://github.com/neovim/nvim-lspconfig/issues/662#issuecomment-1706589179
--
-- Command to toggle inline diagnostics
vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
    local current_value = vim.diagnostic.config().virtual_text
    if current_value then
        vim.diagnostic.config { virtual_text = false }
    else
        vim.diagnostic.config { virtual_text = true }
    end
end, {})

-- Command to toggle diagnostics
vim.api.nvim_create_user_command("DiagnosticsToggle", function()
    local current_value = vim.diagnostic.is_disabled()
    if current_value then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end, {})

-- thanks to Paulobox: https://github.com/neovim/nvim-lspconfig/issues/662#issuecomment-2105390305
vim.keymap.set("n", "<Leader>ii", "<cmd>DiagnosticsToggleVirtualText<CR>", { desc = "Toggle diagnostic virtual text" })
vim.keymap.set("n", "<Leader>id", "<cmd>DiagnosticsToggle<CR>", { desc = "Toggle diagnostics" })
