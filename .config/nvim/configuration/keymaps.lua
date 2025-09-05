local keymaps = {
    --  Reload nvim config with a press of a button (Broken with Lazy)
    -- { 'n', '<F11>', ":luafile ~/.config/nvim/init.lua<CR>:echo 'Config reloaded!'<CR>" },

    --  Use JK keycombo instead of ESC to exit insert mode
    { 'i', 'jk', "<esc>" },

    --  An easier way to switch between splits
    --  (Done by vim-tmux plugin)
    -- { 'n', '<C-h>', "<C-w>h" },
    -- { 'n', '<C-j>', "<C-w>j" },
    -- { 'n', '<C-k>', "<C-w>k" },
    -- { 'n', '<C-l>', "<C-w>l" },

    --  When wrap is enabled, navigating the wraped lines is a pain by default
    { 'n', 'j', "gj" },
    { 'n', 'k', "gk" },

    --  Center after jumps
    { {'n', 'v'}, "<C-f>", "<C-f>zz" },
    { {'n', 'v'}, "<C-b>", "<C-b>zz" },
    { {'n', 'v'}, "<C-d>", "<C-d>zz" },
    { {'n', 'v'}, "<C-u>", "<C-u>zz" },

    --  Search for the highlighted text
    -- { 'v', '/', "y/<C-r><C-0><return><esc>" },

    --  Escape from insert mode in terminal with the same keychord as from regular insert mode
    { 't', "jk", "<C-\\><C-n>" },

    --  Hungarian keyboard shenanigans
    { '', 'é', '$' },

    -- Thanks Primeagen
    { 'v', "J", ":m '>+1<CR>gv=gv" },
    { 'v', "K", ":m '<-2<CR>gv=gv" },

    -- 
    { 'n', "<leader>n", vim.cmd.Ex },

    -- Buffers
    { 'n', "<leader>bp", "<cmd>bprevious<cr>" },
    { 'n', "<leader>bn", "<cmd>bnext<cr>" },
    { 'n', "<C-S-P>", "<cmd>bprevious<cr>" },
    { 'n', "<C-S-N>", "<cmd>bnext<cr>" },
    { 'n', "<C-P>", "<cmd>bprevious<cr>" },
    { 'n', "<C-N>", "<cmd>bnext<cr>" },
    { 'n', "<C-[>", "<cmd>bprevious<cr>" },
    { 'n', "<C-]>", "<cmd>bnext<cr>" },
    { 'n', "<leader>bc", "<cmd>bprevious|bdelete #<cr>" },
    { 'n', "<leader>bo", "<cmd>%bdelete|edit #|normal `\"<cr>" },

    -- Split resizing
    { 'n', "<M-h>", "<C-w>5<" },
    { 'n', "<M-l>", "<C-w>5>" },
    { 'n', "<M-k>", "<C-w>+" },
    { 'n', "<M-j>", "<C-w>-" },

    -- Don't exit visual mode when indenting
    { 'v', "<", "<gv" },
    { 'v', ">", ">gv" },

    -- Other useful
    { 'n', "<leader>tc", "%s/\\s\\+$//e" }
}


local map_options = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Register the keymaps all at once (might be a bit overkill)
for _, v in ipairs(keymaps) do
    if #v == 4 then
        vim.keymap.set(v[1], v[2], v[3], v[4])
    else
        vim.keymap.set(v[1], v[2], v[3], map_options)
    end
end

if vim.loop.os_uname().sysname == "Linux" or vim.loop.os_uname().sysname == "Darwin" then
    vim.keymap.set('n', "<F12>", ":e ~/.config/nvim/init.lua<cr>", map_options)
end
