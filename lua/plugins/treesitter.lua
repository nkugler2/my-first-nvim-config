return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "lua", "vim", "vimdoc", "query",
            "javascript", "typescript", "python",
            "html", "css", "json", "yaml", "markdown",
            "bash", "c", "rust", "go", "sql",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "lua", "vim", "query",
                "javascript", "typescript", "python",
                "html", "css", "json", "yaml", "markdown",
                "bash", "c", "rust", "go", "sql",
            },
            callback = function()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
