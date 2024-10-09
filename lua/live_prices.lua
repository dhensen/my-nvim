local api = vim.api
local prices_win = nil
local buf = nil
local progress_buf = nil
local progress_win = nil
local border_top_window = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┤", "FloatBorder" },
    { "─", "FloatBorder" },
    { "├", "FloatBorder" },
    { "│", "FloatBorder" },
}
local border_bottom_window = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" },
}

local function create_window()
    if prices_win and api.nvim_win_is_valid(prices_win) then
        return
    end

    buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(buf, "bufhidden", "wipe")

    local width = 40
    local height = 6
    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = 2,
        col = vim.o.columns - width - 2,
        border = border_top_window,
    }

    prices_win = api.nvim_open_win(buf, false, opts)

    progress_buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(progress_buf, "bufhidden", "wipe")
    api.nvim_buf_set_option(progress_buf, "modifiable", true)
    api.nvim_buf_set_lines(
        progress_buf,
        0,
        -1,
        false,
        { "[============================================================]" }
    )
    api.nvim_buf_set_option(progress_buf, "modifiable", false)

    progress_win = api.nvim_open_win(progress_buf, false, {
        style = "minimal",
        relative = "editor",
        width = width,
        height = 1,
        row = height + 3,
        col = vim.o.columns - width - 2,
        border = border_bottom_window,
    })
end

local function update_window_position()
    if prices_win and api.nvim_win_is_valid(prices_win) then
        local width = 40
        local height = 6
        local opts = {
            relative = "editor",
            row = 2,
            col = vim.o.columns - width - 2,
            width = width,
            height = height,
        }
        api.nvim_win_set_config(prices_win, opts)

        if progress_win and api.nvim_win_is_valid(progress_win) then
            local progress_opts = {
                relative = "editor",
                width = width,
                height = 1,
                row = height + 3,
                col = vim.o.columns - width - 2,
            }
            api.nvim_win_set_config(progress_win, progress_opts)
        end
    end
end

local function format_price(price)
    if price < 0.01 then
        return string.format("%14s", string.format("€ %.8f", price):gsub("%.", ","):gsub("0+$", ""):gsub(",$", ""))
    else
        return string.format("%14s", string.format("€ %.2f", price):gsub("%.", ","))
    end
end

local function fetch_prices()
    local handle =
        io.popen "curl -s 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,avalanche-2,shiba-inu,solana&vs_currencies=eur'"
    local crypto_result = handle:read "*a"
    handle:close()

    local success, crypto_prices = pcall(vim.json.decode, crypto_result)

    if not success then
        api.nvim_buf_set_option(buf, "modifiable", true)
        api.nvim_buf_set_lines(buf, 0, -1, false, { "Error fetching prices" })
        api.nvim_buf_set_option(buf, "modifiable", false)
        return
    end

    local lines = {}
    for key, value in pairs(crypto_prices) do
        table.insert(lines, string.format("%-15s: %s", key:upper(), format_price(value.eur)))
    end

    api.nvim_buf_set_option(buf, "modifiable", true)
    api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    api.nvim_buf_set_option(buf, "modifiable", false)
end

local function show_prices()
    create_window()
    fetch_prices()

    local progress = 60
    local function update_progress()
        if progress > 0 then
            api.nvim_buf_set_option(progress_buf, "modifiable", true)
            local progress_width = 40
            local scaled_progress = math.floor((progress / 60) * (progress_width - 2))
            local progress_bar = string.rep("=", scaled_progress)
                .. string.rep(" ", (progress_width - 2) - scaled_progress)
            api.nvim_buf_set_lines(progress_buf, 0, -1, false, { string.format("[%s]", progress_bar) })
            api.nvim_buf_set_option(progress_buf, "modifiable", false)
            progress = progress - 1
            vim.defer_fn(update_progress, 1000)
        else
            if prices_win and api.nvim_win_is_valid(prices_win) then
                fetch_prices()
                progress = 60
                show_prices()
            end
        end
    end

    update_progress()
end

local function setup()
    vim.cmd 'command! ShowPrices lua require("live_prices").show_prices()'
    api.nvim_create_autocmd({ "VimResized", "WinNew", "WinClosed" }, {
        callback = function()
            update_window_position()
        end,
    })
end

return {
    show_prices = show_prices,
    setup = setup,
}

-- In your init.lua or init.vim, add:
-- require('live_prices').setup()
-- Then, use :ShowPrices to open the window with live prices.
