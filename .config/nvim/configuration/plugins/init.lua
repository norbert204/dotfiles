-- Misc plugins that don't fit into other categories
return {
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.8',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim"
        },
        config = function()
            local telescope = require('telescope')
            local telescope_builtin = require('telescope.builtin')
            local telescope_themes = require("telescope.themes")
            local telescope_actions = require("telescope.actions")

            telescope.setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            -- ["<tab>"] = "move_selection_next",
                            -- ["<S-tab>"] = "move_selection_previous",
                        },
                        n = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        }
                    }
                },
                extensions = {
                    ["ui-select"] = {
                        telescope_themes.get_dropdown(),
                    }
                },
                pickers = {
                    buffers = {
                        keymaps = {
                            i = {
                                ["<C-x>"] = telescope_actions.delete_buffer,
                            },
                            n = {
                                ["<C-x>"] = telescope_actions.delete_buffer,
                            }
                        }
                    }
                }
            }

            telescope.load_extension("ui-select")

            vim.keymap.set('n', "<leader>ft", telescope_builtin.current_buffer_fuzzy_find)
            vim.keymap.set('n', "<leader>ff", telescope_builtin.find_files)
            vim.keymap.set('n', "<leader>fg", telescope_builtin.git_files)
            vim.keymap.set('n', "<leader>fr", telescope_builtin.resume)
            vim.keymap.set('n', "<leader>fl", telescope_builtin.live_grep)

            -- Telescope git
            -- vim.keymap.set('n', "<leader>gb", telescope_builtin.git_branches)
            -- vim.keymap.set('n', "<leader>gs", telescope_builtin.git_status)

            -- Buffers
            vim.keymap.set('n', "<leader>bb", telescope_builtin.buffers)
        end
    },
    {
        "windwp/nvim-autopairs",
        config = true
    },
    {
        "Pocco81/auto-save.nvim",
        opts = {
            execution_message = {
                message = ""
            }
        },
        config = true
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = true,
    },
    {
        "tiagovla/scope.nvim",
        config = true,
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set('n', "<leader>ha", function() harpoon:list():add() end)
            vim.keymap.set('n', "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set('n', "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set('n', "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set('n', "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set('n', "<leader>4", function() harpoon:list():select(4) end)
        end
    },
}
