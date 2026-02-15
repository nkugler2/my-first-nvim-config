----------------- My Keybinds ---------------
--- These should be things that start with:
--- `vim.keymap.set(`

-- This changes the annoying keybind for going to normal mode in the termianl
-- from Ctrl \ and then Ctrl n t0 just Escape
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>e', ':Rexplore<CR>')

-- Keep visual mode on after indenting text selected in visual mode
-- Allows for you to indent more than once with visual mode selected text
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- Normal behavior: All text during one insert mode counts towards 1 undo
-- This behavior: Punctuations are now what counts for undo steps
-- ALlows: for undoing sentances/smaller sections rather than paragraphs or 
--  larger sections of text
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- Easier movement through buffers (Shift l and Shift h)
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Go to Left Window", remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Go to Lower Window", remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Go to Upper Window", remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Go to Right Window", remap = true })

-- Using Alt/Option for resizing instead of Control
-- Not working???
vim.keymap.set('n', '<M-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<M-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<M-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

