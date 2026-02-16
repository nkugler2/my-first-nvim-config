return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "→",
                    package_uninstalled = "×",
                },
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "pyright",       -- Python - type checking and completion
                "ruff",          -- Python - linting and formatting
                "lua_ls",        -- Lua
                "yamlls",        -- YAML
                "html",          -- HTML
                "cssls",         -- CSS
                "ts_ls",         -- JavaScript (and TypeScript)
                "jsonls",        -- JSON
                "sqlls",         -- SQL - might want to try sqls if I want to execute code?
                "dockerls",      -- Dockerfile
                "marksman",      -- Markdown
            },
            -- automatic_enable is true by default in v2, so all installed
            -- servers get enabled via vim.lsp.enable() automatically
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- lua_ls: tell it about the vim global
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            -- pyright: disable organize imports and linting so ruff handles those
            vim.lsp.config("pyright", {
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- ignore all files for linting, ruff handles it
                            ignore = { "*" },
                        },
                    },
                },
            })

            -- Keymaps that activate when an LSP attaches to a buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    -- disable ruff's hover so pyright handles it
                    if client and client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end

                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
                    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                end,
            })
        end,
    },
}
