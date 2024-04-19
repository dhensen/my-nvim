local function change_colorscheme()
    local hour = os.date("*t").hour

    if hour >= 18 or hour < 9 then
        -- During the night
        vim.cmd "colorscheme rose-pine-moon"
    else
        -- During the day
        vim.cmd "colorscheme rose-pine-dawn"
    end
end

change_colorscheme()

-- Set an autocmd to check every hour
-- vim.api.nvim_create_augroup("AutoChangeColorscheme", { clear = true })
-- vim.api.nvim_create_autocmd("CursorHold", {
--     group = "AutoChangeColorscheme",
--     pattern = "*",
--     callback = change_colorscheme,
--     desc = "Change colorscheme based on time of day",
-- })
