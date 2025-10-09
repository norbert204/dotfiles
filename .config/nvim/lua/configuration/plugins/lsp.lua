vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        vim.diagnostic.config({ virtual_text = true })

        local telescope_builtin = require('telescope.builtin')
        local keymap_opts = { buffer = args.buf }

        vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, keymap_opts)
        vim.keymap.set('n', '<leader>lk', vim.lsp.buf.hover, keymap_opts)
        vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, keymap_opts)
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, keymap_opts)
        vim.keymap.set({ 'n', 'v' }, '<leader><return>', vim.lsp.buf.code_action, keymap_opts)

        vim.keymap.set('n', "gd", telescope_builtin.lsp_definitions, keymap_opts)
        vim.keymap.set('n', "gi", telescope_builtin.lsp_implementations, keymap_opts)
        vim.keymap.set('n', "gr", telescope_builtin.lsp_references, keymap_opts)
        vim.keymap.set('n', 'gD', telescope_builtin.lsp_type_definitions, keymap_opts)
    end,
})

return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            keymap = {
                preset = "none",
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<cr>'] = { 'accept', 'fallback' },

                ["<Tab>"] = { 'select_next', 'fallback' },
                ["<S-Tab>"] = { 'select_prev', 'fallback' },

                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },
            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    }
                },
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
                -- providers = {
                --     ["easy-dotnet"] = {
                --         name = "easy-dotnet",
                --         enabled = true,
                --         module = "easy-dotnet.completion.blink",
                --         score_offset = 10000,
                --         async = true,
                --     },
                -- }
            },
            cmdline = {
                completion = {
                    menu = {
                        auto_show = true,
                    },
                    list = {
                        selection = {
                            preselect = false,
                            auto_insert = true,
                        }
                    },
                },
                keymap = {
                    preset = "inherit",
                }
            }
        }
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason").setup {
                registries = {
                    "github:mason-org/mason-registry",
                    "github:crashdummyy/mason-registry",
                }
            }

            require("mason-lspconfig").setup {
                automatic_installation = true,
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "pyright",
                    "clangd",
                    "html",
                    "cssls",
                    "emmet_ls",
                    -- "roslyn",
                    -- "rzls",
                }
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
        end
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup()

            vim.keymap.set('n', "<leader>lt", "<cmd>Trouble diagnostics toggle<CR>")
        end
    },
    {
        'stevearc/conform.nvim',
        config = function()
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

            vim.keymap.set('n', "<leader>lf", function()
                print("Formatting buffer...")
                conform.format({
                    lsp_fallback = true,
                    timeout_ms = 15000 -- Resharper is slow
                })
            end)
        end
    }
}
