vim.g.mapleader = " "

vim.keymap.set('i', "jk", "<esc>")
vim.keymap.set('n', "<f12>", "<cmd>e ~/.config/nvim/init.lua<cr>")
vim.keymap.set('n', "<f11>", function()
    vim.cmd("source")
    print("Sourced file")
end)
vim.keymap.set('n', "<leader>n", "<cmd>Ex<cr>")
vim.keymap.set({ 'n', 'v', 'x' }, "<A-p>", "\"+p")
vim.keymap.set({ 'n', 'v', 'x' }, "<A-y>", "\"+y")
vim.keymap.set('n', "<C-[>", "<cmd>bprev<cr>")
vim.keymap.set('n', "<C-]>", "<cmd>bnext<cr>")
vim.keymap.set('n', "<leader>bc", "<cmd>bdelete!|bprev<cr>")

-- Lua?
-- vim.keymap.set('i', "<tab>", [[ pumvisible() ? "\<C-n>" : "\<tab>" ]], { expr = true })
-- vim.keymap.set('i', "<S-tab>", [[ pumvisible() ? "\<C-p>" : "\<S-tab>" ]], { expr = true })
-- vim.keymap.set('i', "<cr>", [[ pumvisible() ? \"<C-y>" : \"<cr>" ]], { expr = true }) -- Didn't work
