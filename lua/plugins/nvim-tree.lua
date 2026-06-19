return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        require("nvim-tree").setup {
            on_attach = function(bufnr)
                local api = require "nvim-tree.api"
                api.config.mappings.default_on_attach(bufnr)

                local function open_in_system_file_browser(node)
                    if not node or (node.type ~= "file" and node.type ~= "symlink") then
                        vim.notify("Please select a file node, not a directory or special item.", vim.log.levels.ERROR)
                        return
                    end

                    local path = node.link_to or node.absolute_path
                    if type(path) ~= "string" or path == "" then
                        vim.notify("Could not determine file path!", vim.log.levels.ERROR)
                        return
                    end

                    local open_cmd
                    if vim.fn.has "mac" == 1 then
                        open_cmd = 'open "' .. vim.fn.fnamemodify(path, ":h") .. '"'
                    elseif vim.fn.has "unix" == 1 then
                        open_cmd = 'xdg-open "' .. vim.fn.fnamemodify(path, ":h") .. '"'
                    elseif vim.fn.has "win32" == 1 then
                        open_cmd = 'start "" "' .. vim.fn.fnamemodify(path, ":h") .. '"'
                    else
                        vim.notify("No known way to open file browser on this OS!", vim.log.levels.ERROR)
                        return
                    end

                    vim.fn.system(open_cmd)
                end

                vim.keymap.set("n", "gF", function()
                    local node = api.tree.get_node_under_cursor()
                    if node then
                        open_in_system_file_browser(node)
                    end
                end, { buffer = bufnr, desc = "Open parent folder in system file browser" })
            end,
        }
    end,
}
