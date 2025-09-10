vim.keymap.set('n', "<leader>gg", "<cmd>Neogit<cr>")

require("diffview").setup {
    hooks = {
        diff_buf_win_enter = function()
            vim.opt_local.foldenable = false
            vim.opt_local.fillchars = "diff: "
        end,
    },
    keymaps = {
        view = {
            [ "<C-j>" ] = "]c",
            [ "<C-k>" ] = "[c",
            [ "q" ] = "<cmd>DiffviewClose<cr>",
        },
        file_panel = {
            [ "q" ] = "<cmd>DiffviewClose<cr>",
        }
    },
}
