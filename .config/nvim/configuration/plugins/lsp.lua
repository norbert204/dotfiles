return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- "lvimuser/lsp-inlayhints.nvim",
        },
        config = function()
            -- local inlay_hints = require("lsp-inlayhints")
            -- inlay_hints.setup()

            local telescope_builtin = require('telescope.builtin')

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),

                callback = function(args)
                    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = { buffer = args.buf }

                    -- Need to rethink this
                    vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, opts)
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', '<leader>lk', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
                    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
                    vim.keymap.set({'n', 'v'}, '<leader><return>', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts)
                    vim.keymap.set('n', "gd", telescope_builtin.lsp_definitions, opts)
                    vim.keymap.set('n', "gi", telescope_builtin.lsp_implementations, opts)
                    vim.keymap.set('n', "gr", telescope_builtin.lsp_references, opts)

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- inlay_hints.on_attach(client, bufnr)
                end,
            })
        end
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "1.*",
        opts = {
            keymap = {
                preset = "none",
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<cr>'] = { 'accept', 'fallback' },

                -- ['<Tab>'] = {
                --     function(cmp)
                --         if cmp.snippet_active() then return cmp.accept()
                --         else return cmp.select_and_accept() end
                --     end,
                --     'snippet_forward',
                --     'fallback'
                -- },
                -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
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
                    }
                },
                keymap = {
                    preset = "super-tab",
                    ["<C-k>"] = { "select_prev", "fallback" },
                    ["<C-j>"] = { "select_next", "fallback" },
                }
            }
        }
    },
    -- {
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-nvim-lsp-signature-help",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-path",
    --         "hrsh7th/cmp-cmdline",
    --         "saadparwaiz1/cmp_luasnip",
    --         "L3MON4D3/LuaSnip",
    --
    --         "windwp/nvim-autopairs",
    --         "saecki/crates.nvim",
    --     },
    --     config = function()
    --         local cmp = require("cmp")
    --
    --         -- cmp.register_source("easy-dotnet", require("easy-dotnet").package_completion_source)
    --
    --         cmp.setup {
    --             snippet = {
    --                 expand = function(args)
    --                     require('luasnip').lsp_expand(args.body)
    --                 end,
    --             },
    --             window = {
    --                 completion = cmp.config.window.bordered(),
    --                 documentation = cmp.config.window.bordered(),
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ['<tab>'] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_next_item()
    --                     else
    --                         fallback()
    --                     end
    --                 end),
    --                 ['<S-tab>'] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_prev_item()
    --                     else
    --                         fallback()
    --                     end
    --                 end),
    --                 -- ['<C-Space>'] = cmp.mapping.complete(),
    --                 ['<C-e>'] = cmp.mapping.abort(),
    --                 ['<CR>'] = cmp.mapping.confirm({ select = true }),
    --             }),
    --             sources = cmp.config.sources({
    --                 { name = "nvim_lsp" },
    --                 { name = "nvim_lsp_signature_help" },
    --                 -- { name = "luasnip" },
    --                 { name = "buffer" },
    --                 { name = "path" },
    --                 -- Extra from plugins
    --                 { name = "crates" },
    --                 -- { name = 'easy-dotnet' },
    --             }),
    --         }
    --
    --         cmp.setup.cmdline('/', {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = {
    --                 { name = 'buffer' }
    --             }
    --         })
    --
    --         cmp.setup.cmdline(':', {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 { name = 'path' }
    --             }, {
    --                 { name = 'cmdline' }
    --             })
    --         })
    --
    --         local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    --
    --         cmp.event:on(
    --             'confirm_done',
    --             cmp_autopairs.on_confirm_done()
    --         )
    --     end
    -- },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            --"hrsh7th/cmp-nvim-lsp",
            -- "saghen/blink.cmp",
        },
        config = function()
            -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

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

            require("lspconfig")["lua_ls"].setup {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim', "require" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            }

            -- require("mason-lspconfig").setup_handlers {
            --     function(server_name)
            --         require("lspconfig")[server_name].setup {
            --             capabilities = capabilities,
            --         }
            --     end,
            -- }
        end
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup()

            vim.keymap.set('n', "<leader>lt", "<cmd>Trouble diagnostics toggle<CR>")
        end
    }
}
