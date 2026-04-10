require("mason").setup {
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
}

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
    },
    cmdline = {
        keymap = {
            preset = 'inherit'
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                }
            },
            menu = {
                auto_show = true
            }
        },
    }
}

local conform = require("conform")
local conform_util = require("conform.util")

conform.setup {
    async = true,
    formatters_by_ft = {
        cs = { "resharper" },
        csproj = { "resharper" },
        sln = { "resharper" },
        razor = { "resharper" },
    },
    formatters = {
        resharper = {
            inherit = false,
            command = conform_util.find_executable({"/Users/nhorvath/.dotnet/tools/jb"}, "jb"),
            args = { "cleanupcode", "$FILENAME" },
            stdin = false,
        }
    }
}

-- Do I want to set this keybinding when the LSP attaches?
vim.keymap.set('n', "<leader>lf", function()
    print("Formatting buffer...")
    conform.format({
        lsp_fallback = true,
        timeout_ms = 15000 -- Resharper is slow
    })
end)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        vim.diagnostic.config({ virtual_text = true })

        -- Register keymaps for current buffer
        local keymap_opts = { buffer = args.buf }
        local fzf = require("fzf-lua")

        vim.keymap.set('n', "<leader>lk", vim.lsp.buf.hover, keymap_opts)
        vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, keymap_opts)
        vim.keymap.set('n', "<leader>lr", vim.lsp.buf.rename, keymap_opts)
        vim.keymap.set('n', "<leader>le", vim.diagnostic.open_float, keymap_opts)
        vim.keymap.set({ 'n', 'v' }, '<leader><return>', fzf.lsp_code_actions, keymap_opts)

        vim.keymap.set('n', "gd", fzf.lsp_definitions, keymap_opts)
        vim.keymap.set('n', "gi", fzf.lsp_implementations, keymap_opts)
        vim.keymap.set('n', "gr", fzf.lsp_references, keymap_opts)
        vim.keymap.set('n', "gD", fzf.lsp_typedefs, keymap_opts)
    end
})
