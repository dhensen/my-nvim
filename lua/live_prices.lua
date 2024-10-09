local api = vim.api
local prices_win = nil
local buf = nil
local should_update = true
local selected_coins = { "bitcoin", "ethereum", "avalanche-2", "shiba-inu", "solana" }
local data_file = vim.fn.stdpath "data" .. "/live_prices_config.json"

local function load_config()
    local file = io.open(data_file, "r")
    if file then
        local content = file:read "*a"
        file:close()
        local success, loaded_config = pcall(vim.json.decode, content)
        if success and loaded_config then
            selected_coins = loaded_config
        end
    end
end

local function save_config()
    local file = io.open(data_file, "w")
    if file then
        file:write(vim.json.encode(selected_coins))
        file:close()
    end
end

local function create_window()
    if prices_win and api.nvim_win_is_valid(prices_win) then
        return
    end

    buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(buf, "bufhidden", "wipe")

    local width = 40
    local height = #selected_coins + 2
    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = 2,
        col = vim.o.columns - width - 2,
        border = "rounded",
    }

    prices_win = api.nvim_open_win(buf, false, opts)

    api.nvim_buf_set_option(buf, "modifiable", true)
    api.nvim_buf_set_lines(buf, 0, height, false, {
        string.rep("", height - 1),
        "[============================================================]",
    })
    api.nvim_buf_set_option(buf, "modifiable", false)
end

local function update_window_position()
    if prices_win and api.nvim_win_is_valid(prices_win) then
        local width = 40
        local height = #selected_coins + 2
        local opts = {
            relative = "editor",
            row = 2,
            col = vim.o.columns - width - 2,
            width = width,
            height = height,
        }
        api.nvim_win_set_config(prices_win, opts)
    end
end

local function format_price(price)
    if price == nil then
        return "Price unavailable"
    elseif price < 0.01 then
        return string.format("%14s", string.format("€ %.8f", price):gsub("%.", ","):gsub("0+$", ""):gsub(",$", ""))
    else
        return string.format("%14s", string.format("€ %.2f", price):gsub("%.", ","))
    end
end

local function fetch_prices()
    local coin_ids = table.concat(selected_coins, ",")
    local handle =
        io.popen("curl -s 'https://api.coingecko.com/api/v3/simple/price?ids=" .. coin_ids .. "&vs_currencies=eur'")
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
    for _, coin in ipairs(selected_coins) do
        local name = coin:gsub("%-%d*$", ""):gsub("%-", " "):gsub("%l", string.upper, 1)
        local price = crypto_prices[coin] and crypto_prices[coin].eur or nil
        table.insert(lines, string.format("%-15s: %s", name, format_price(price)))
    end

    api.nvim_buf_set_option(buf, "modifiable", true)
    api.nvim_buf_set_lines(buf, 0, #lines, false, lines)
    api.nvim_buf_set_option(buf, "modifiable", false)
end

local function show_prices()
    if prices_win and api.nvim_win_is_valid(prices_win) then
        return
    end

    should_update = true
    create_window()
    fetch_prices()

    local progress = 60
    local function update_progress()
        if not should_update then
            return
        end

        if progress > 0 then
            api.nvim_buf_set_option(buf, "modifiable", true)
            local progress_width = 40
            local scaled_progress = math.floor((progress / 60) * (progress_width - 2))
            local progress_bar = string.rep("=", scaled_progress)
                .. string.rep(" ", (progress_width - 2) - scaled_progress)
            api.nvim_buf_set_lines(
                buf,
                #selected_coins,
                #selected_coins + 1,
                false,
                { string.format("[%s]", progress_bar) }
            )
            api.nvim_buf_set_option(buf, "modifiable", false)
            progress = progress - 1
            vim.defer_fn(update_progress, 1000)
        else
            if prices_win and api.nvim_win_is_valid(prices_win) then
                fetch_prices()
                progress = 60
                update_progress()
            end
        end
    end

    update_progress()
end

local function hide_prices()
    should_update = false
    if prices_win and api.nvim_win_is_valid(prices_win) then
        api.nvim_win_close(prices_win, true)
        prices_win = nil
    end
end

local function toggle_show_prices()
    if prices_win and api.nvim_win_is_valid(prices_win) then
        hide_prices()
    else
        show_prices()
    end
end

local function select_coins()
    local handle = io.popen "curl -s 'https://api.coingecko.com/api/v3/coins/list'"
    local result = handle:read "*a"
    handle:close()

    local success, coins = pcall(vim.json.decode, result)
    if not success then
        print "Error fetching coin list."
        return
    end

    local coin_buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(coin_buf, "bufhidden", "wipe")
    vim.cmd "vsplit"
    local coin_win = api.nvim_get_current_win()
    api.nvim_win_set_buf(coin_win, coin_buf)

    local coin_lines = {}
    for _, coin in ipairs(coins) do
        table.insert(
            coin_lines,
            (vim.tbl_contains(selected_coins, coin.id) and "[x] " or "[ ] ") .. coin.id .. " - " .. coin.name
        )
    end

    api.nvim_buf_set_lines(coin_buf, 0, -1, false, coin_lines)
    api.nvim_buf_set_option(coin_buf, "modifiable", false)

    local function toggle_selection(line)
        local coin_id = coins[line + 1].id
        if vim.tbl_contains(selected_coins, coin_id) then
            selected_coins = vim.tbl_filter(function(id)
                return id ~= coin_id
            end, selected_coins)
        else
            table.insert(selected_coins, coin_id)
        end
        save_config()
    end

    api.nvim_buf_set_keymap(
        coin_buf,
        "n",
        "<CR>",
        "<cmd>lua live_prices.toggle_coin_selection()<CR>",
        { noremap = true, silent = true }
    )
    api.nvim_buf_set_keymap(
        coin_buf,
        "n",
        "<leader>s",
        "<cmd>lua live_prices.save_and_close_selection()<CR>",
        { noremap = true, silent = true }
    )

    _G.live_prices = {
        toggle_coin_selection = function()
            local line = api.nvim_win_get_cursor(coin_win)[1] - 1
            toggle_selection(line)
            api.nvim_buf_set_option(coin_buf, "modifiable", true)
            local updated_lines = {}
            for _, coin in ipairs(coins) do
                table.insert(
                    updated_lines,
                    (vim.tbl_contains(selected_coins, coin.id) and "[x] " or "[ ] ") .. coin.id .. " - " .. coin.name
                )
            end
            api.nvim_buf_set_lines(coin_buf, 0, -1, false, updated_lines)
            api.nvim_buf_set_option(coin_buf, "modifiable", false)
        end,
        save_and_close_selection = function()
            api.nvim_win_close(coin_win, true)
            save_config()
        end,
    }
end

local function setup()
    load_config()
    vim.cmd 'command! ShowPrices lua require("live_prices").show_prices()'
    vim.cmd 'command! ToggleShowPrices lua require("live_prices").toggle_show_prices()'
    vim.cmd 'command! SelectCoins lua require("live_prices").select_coins()'
    api.nvim_create_autocmd({ "VimResized", "WinNew", "WinClosed" }, {
        callback = function()
            update_window_position()
        end,
    })
end

return {
    show_prices = show_prices,
    hide_prices = hide_prices,
    toggle_show_prices = toggle_show_prices,
    select_coins = select_coins,
    setup = setup,
}

-- In your init.lua or init.vim, add:
-- require('live_prices').setup()
-- Then, use :ShowPrices to open the window with live prices, :ToggleShowPrices to toggle it, or :SelectCoins to select which coins to display.
