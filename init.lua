-------- All of the following were taken from the example.lua file -----------
------- `:read $VIMRUNTIME/example_init.lua` to see the file again -----------

-- Keybinds
-- Keep mapleader before any other keybind
-- WARNING: This won't work until I set up custom keymaps like <leader>w for save
vim.g.mapleader = ' '

-- Print the line number in front of each line
vim.o.number = true

-- Highlight the line where the cursor is on
-- Very subtle when i first did this, see if I can make this more apparent
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Show <tab> and trailing spaces
vim.o.list = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

-- Use <Esc> to exit terminal mode instead of C-\ and then C-n
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
-- Note: This is an example of adding optional packages
vim.cmd('packadd! nohlsearch')

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

--------------- End of things taken from example.lua ----------------------------



--------------------- My Conig Changes -----------------------------------



-- Sets update times of things like  CursorHold  events, swap file writes, 
-- and LSP hover info trigger faster
-- TEST THIS WHEN I HAVE THINGS UP LATER
-- 	Is it good to have this quick an update?
vim.o.updatetime = 250


------------------------------- My Keybinds ----------------------------------

-- This changes the annoying keybind for going to normal mode in the termianl
-- from Ctrl \ and then Ctrl n t0 just Escape
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>e', ':Rexplore<CR>')

------------------------------- Editing Changes -----------------------------------

-- Persistent Undo - Keeps undo history on disk, so have it even after closing a file
vim.o.undofile = true

vim.o.expandtab = true    -- use spaces instead of tabs
vim.o.shiftwidth = 4      -- indent width (can change to 2)
vim.o.tabstop = 4         -- tab display width
vim.o.smartindent = true   -- auto-indent new lines based on syntax


------------------------------- Visual Changes -----------------------------------

-- Split behavior - Default feels backwards
vim.o.splitright = true  -- vertical splits open to the right instead of left
vim.o.splitbelow = true  -- horizontal splits open below instead of above

-- where git markers, diagnostics, etc. appear - this makes these always visable
-- Basically makes the line numbers always slightly more to the right to leave room on the left
vim.o.signcolumn = 'yes'


------------------------ Lanugage Specific Settings -------------------
-- This sets the host python version for neovim
-- This is not the same as the environment im using, this is for running python commands in neovim
vim.g.python3_host_prog = vim.fn.expand("/Users/noahkugler/.pyenv/versions/3.12.10/envs/NeovimPyVenv/bin/python")
