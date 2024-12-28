-- Add additional capabilities supported by nvim-cmp
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require "lspconfig"
local navic = require "nvim-navic"
navic.setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { buffer = ev.buf }
        local function with_desc(desc)
            return vim.tbl_extend("force", bufopts, { desc = desc })
        end

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, with_desc "Go to declaration")
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, with_desc "Go to definition")
        vim.keymap.set("n", "gw", function()
            vim.cmd "vsplit"
            vim.lsp.buf.definition()
        end, with_desc "Go to definition in a new window")
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, with_desc "Go to implementation")
        vim.keymap.set("n", "K", vim.lsp.buf.hover, with_desc "Show hover information")
        vim.keymap.set("n", "<space>k", vim.lsp.buf.signature_help, with_desc "Show signature help")
        vim.keymap.set("n", "<space>ws", vim.lsp.buf.workspace_symbol, with_desc "Search workspace symbols")
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, with_desc "Add workspace folder")
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, with_desc "Remove workspace folder")
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, with_desc "List workspace folders")
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, with_desc "Go to type definition")
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, with_desc "Code action")
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, with_desc "Rename")
        vim.keymap.set("n", "<space>rr", vim.lsp.buf.references, with_desc "References")
        vim.keymap.set("n", "gr", vim.lsp.buf.references, with_desc "References")
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format { async = true }
        end, with_desc "Format")
    end,
})

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
lspconfig.pyright.setup { flags = lsp_flags, on_attach = on_attach }
-- lspconfig.pyright.setup {
--     flags = lsp_flags,
--     settings = {
--         pyright = {
--             -- Using Ruff's import organizer
--             disableOrganizeImports = true,
--         },
--         python = {
--             analysis = {
--                 -- Ignore all files for analysis to exclusively use Ruff for linting
--                 ignore = { "*" },
--             },
--         },
--     },
-- }
lspconfig.lua_ls.setup { flags = lsp_flags }
lspconfig.ts_ls.setup { flags = lsp_flags }
lspconfig.ruff.setup { flags = lsp_flags }
lspconfig.terraformls.setup { flags = lsp_flags }

-- luasnip setup
local luasnip = require "luasnip"

-- nvim-cmp setup
local cmp = require "cmp"
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
    },
}
