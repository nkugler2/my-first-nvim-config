-- Keep mapleader before any other keybind
-- WARNING: This doesn't work until I set up custom keymaps like <leader>w for save
vim.g.mapleader = ' '

require("noah.options")
require("noah.keybinds")
require("noah.autocmds")
require("noah.languages")
