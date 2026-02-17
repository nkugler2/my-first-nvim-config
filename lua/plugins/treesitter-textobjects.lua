return  {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      init = function()
        -- Disable entire built-in ftplugin mappings to avoid conflicts.
        -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
        vim.g.no_plugin_maps = true

        -- Or, disable per filetype (add as you like)
        -- vim.g.no_python_maps = true
        -- vim.g.no_ruby_maps = true
        -- vim.g.no_rust_maps = true
        -- vim.g.no_go_maps = true
      end,
      config = function()
              -- configuration
          require("nvim-treesitter-textobjects").setup {
            select = {
              -- Automatically jump forward to textobj, similar to targets.vim
              lookahead = true,
              -- You can choose the select mode (default is charwise 'v')
              --
              -- Can also be a function which gets passed a table with the keys
              -- * query_string: eg '@function.inner'
              -- * method: eg 'v' or 'o'
              -- and should return the mode ('v', 'V', or '<c-v>') or a table
              -- mapping query_strings to modes.

              -- selection_modes allows for using a certain visual mode by default for a specific object
                -- ex/ my first one means the default visual for grabing a parameter is by characters
                -- and NOT by visual line or visual block
              selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                -- ['@function.outer'] = 'V', -- linewise (might want later)
                -- ['@class.outer'] = '<c-v>', -- blockwise (might want later)
              },
              -- If you set this to `true` (default is `false`) then any textobject is
              -- extended to include preceding or succeeding whitespace. Succeeding
              -- whitespace has priority in order to act similarly to eg the built-in
              -- `ap`.
              --
              -- Can also be a function which gets passed a table with the keys
              -- * query_string: eg '@function.inner'
              -- * selection_mode: eg 'v'
              -- and should return true of false
              include_surrounding_whitespace = false,
            },
          }
          ----------- keymaps ------------
          -- You can use the capture groups defined in `textobjects.scm`

          -- These are keymaps for selecting different kinds of textobjects like functions, classes, or some local scope
          vim.keymap.set({ "x", "o" }, "af", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
          end)
          vim.keymap.set({ "x", "o" }, "if", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
          end)
          vim.keymap.set({ "x", "o" }, "ac", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
          end)
          vim.keymap.set({ "x", "o" }, "ic", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
          end)

          -- You can also use captures from other query groups like `locals.scm`
          vim.keymap.set({ "x", "o" }, "as", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
          end)
          -- These next ones are for swaping things like parameters and statements (sentances)
          vim.keymap.set("n", "<leader>a", function()
            require("nvim-treesitter-textobjects.swap").swap_next "@parameter.outer"
          end)
          vim.keymap.set("n", "<leader>A", function()
            require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
          end)
          vim.keymap.set("n", "<leader>l", function()
            require("nvim-treesitter-textobjects.swap").swap_next "@statement.outer"
          end)
          vim.keymap.set("n", "<leader>L", function()
            require("nvim-treesitter-textobjects.swap").swap_previous "@statement.outer"
          end)
          --- can add other things here like function, class attributes, etc. ---

          -- Finally, we define the move to next/previous textobjects
          vim.keymap.set({ "n", "x", "o" }, "<leader>c", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer", "textobjects")
          end)
          vim.keymap.set({ "n", "x", "o" }, "<leader>C", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer", "textobjects")
          end)
          vim.keymap.set({ "n", "x", "o" }, "<leader>m", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
          end)
          vim.keymap.set({ "n", "x", "o" }, "<leader>M", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
          end)
          vim.keymap.set({ "n", "x", "o" }, "<leader>p", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.outer", "textobjects")
          end)
          vim.keymap.set({ "n", "x", "o" }, "<leader>P", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.outer", "textobjects")
          end)
      end,
}
