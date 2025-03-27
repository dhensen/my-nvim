return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup {
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<C-j>",
                },
            },
            filetypes = {
                markdown = true, -- overrides default
                sh = function()
                    if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
                        -- disable for .env files
                        return false
                    end
                    return true
                end,
            },
            copilot_model = "gpt-4o-copilot",
        }
    end,
}
