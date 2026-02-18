-------- All of the following were taken from the example.lua file -----------
------- `:read $VIMRUNTIME/example_init.lua` to see the file again -----------

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

-- Add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
-- Note: This is an example of adding optional packages
vim.cmd('packadd! nohlsearch')

--------------- End of things taken from example.lua ----------------------------



--------------------- My Conig Changes -----------------------------------



-- Sets update times of things like  CursorHold  events, swap file writes,
-- and LSP hover info trigger faster
-- TEST THIS WHEN I HAVE THINGS UP LATER
-- 	Is it good to have this quick an update?
vim.o.updatetime = 250

-- Enable termguicolors for catppuccin
vim.opt.termguicolors = true

-------- Rip Grep ----------
-- Replaces standard grep with Ripgrep for neovim
vim.o.grepprg = 'rg --vimgrep'

-- Formatting ripgrep
-- %f — filename
-- %l — line number
-- %c — column number
-- %m — match text (the rest of the line)
vim.o.grepformat = '%f:%l:%c:%m'


------------------------------- Editing Changes -----------------------------------

-- Persistent Undo - Keeps undo history on disk, so have it even after closing a file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.expandtab = true   -- use spaces instead of tabs
vim.o.shiftwidth = 4     -- indent width (can change to 2)
vim.o.tabstop = 4        -- tab display width
vim.o.smartindent = true -- auto-indent new lines based on syntax

vim.o.inccommand = 'split'

-- Should relate to the "Show <tab> and trailing spaces from the video suggestions above
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


------------------------------- Visual Changes -----------------------------------

-- Split behavior - Default feels backwards
vim.o.splitright = true -- vertical splits open to the right instead of left
vim.o.splitbelow = true -- horizontal splits open below instead of above

-- where git markers, diagnostics, etc. appear - this makes these always visable
-- Basically makes the line numbers always slightly more to the right to leave room on the left
vim.o.signcolumn = 'yes'
