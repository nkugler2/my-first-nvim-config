return {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    opts = {
        keymap = {
            preset = "default",
            -- default uses C-y to accept, C-n/C-p to navigate
            -- which matches vanilla vim completion behavior
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
        },
    },
}
