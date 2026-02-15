return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "lua", "vim", "vimdoc", "query",
                "javascript", "typescript", "python",
                "html", "css", "json", "yaml", "markdown",
                "bash", "c", "rust", "go", "sql",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        })
    end,
}
