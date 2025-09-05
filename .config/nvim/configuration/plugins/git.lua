return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "sindrets/diffview.nvim",
        },
        opts = {
            graph_style = "unicode",
            kind = "replace",
            integrations = {
                telescope = true,
            }
        },
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>" },
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup()

            vim.keymap.set('n', "<leader>gp", gitsigns.preview_hunk, { noremap = true })
        end
    },
    {
        "sindrets/diffview.nvim",
        config = true,
        opts = {
            hooks = {
                diff_buf_win_enter = function()
                    vim.opt_local.foldenable = false
                    vim.opt_local.fillchars = "diff: "
                end,
            },
            keymaps = {
                view = {
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
                    { "n", "<leader>gdm", "<cmd>DiffviewOpen main<cr>", { desc = "Open diffview for main branch" } },
                }
            }
        }
    },

}
