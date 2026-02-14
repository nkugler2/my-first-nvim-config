------------------------------- My Keybinds ----------------------------------

-- This changes the annoying keybind for going to normal mode in the termianl
-- from Ctrl \ and then Ctrl n t0 just Escape
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>e', ':Rexplore<CR>')
