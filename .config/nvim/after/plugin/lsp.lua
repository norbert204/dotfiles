require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
    },
}

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
            runtime = {
                version = 'LuaJIT'
            },
            telemetry = { enable = false },
            diagnostics = {
                globals = { "vim" },
            },
        }
    },
})

require("blink.cmp").setup {
    completion = {
        documentation = {
            auto_show = true
        },
        list = {
            selection = {
                preselect = false,
                auto_insert = true,
            }
        }
    },
    signature = { enabled = true },
    keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        -- TODO: snippet support
        ['<CR>'] = { 'accept', 'fallback' },
        ["<Tab>"] = { 'select_next', 'fallback' },
        ["<S-tab>"] = { 'select_prev', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    }
}

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        vim.diagnostic.config({ virtual_text = true })

        local telescope_builtin = require("telescope.builtin")

        -- Register keymaps for current buffer
        local keymap_opts = { buffer = args.buf }

        vim.keymap.set('n', "<leader>lk", vim.lsp.buf.hover, keymap_opts)
        vim.keymap.set('n', "<leader>lr", vim.lsp.buf.rename, keymap_opts)
        vim.keymap.set('n', "<leader><return>", vim.lsp.buf.code_action, keymap_opts)
        vim.keymap.set('n', "<leader>lf", vim.lsp.buf.format, keymap_opts)
        vim.keymap.set('n', "<leader>le", vim.diagnostic.open_float, keymap_opts)

        vim.keymap.set('n', "gd", telescope_builtin.lsp_definitions, keymap_opts)
        vim.keymap.set('n', "gi", telescope_builtin.lsp_implementations, keymap_opts)
        vim.keymap.set('n', "gr", telescope_builtin.lsp_references, keymap_opts)
        vim.keymap.set('n', "gD", telescope_builtin.lsp_type_definitions, keymap_opts)
    end
})
