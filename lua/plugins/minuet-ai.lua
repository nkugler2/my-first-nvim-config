return {
    -- ==========================================================================
    -- TAB COMPLETION: minuet-ai.nvim with Ollama (LOCAL)
    -- ==========================================================================
    {
        "milanglacier/minuet-ai.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("minuet").setup({
                -- Provider configuration
                -- minuet-ai dropped the native ollama provider; use openai_fim_compatible
                -- pointed at Ollama's local OpenAI-compatible endpoint instead
                provider = "openai_fim_compatible",

                -- Request parameters
                request_timeout = 3, -- Seconds to wait for completion

                -- Completion behavior
                throttle = 1000, -- ms delay before requesting completion


                -- Provider options
                provider_options = {
                    openai_fim_compatible = {
                        name = "Ollama",
                        model = "qwen2.5-coder:7b",
                        end_point = "http://localhost:11434/v1/completions",
                        -- Ollama doesn't require a real key; TERM is always set in terminal
                        api_key = "TERM",
                        stream = true,
                        optional = {
                            max_tokens = 256,
                            stop = { "<|endoftext|>" },
                        },
                    },
                },

                -- UI/Display settings
                notify = "error", -- Only show errors, not every completion

                -- NOTE: If using blink.cmp, minuet will automatically integrate
                -- You can choose completion mode:
                -- - "inline" (default): Ghost text suggestions
                -- - "manual": Only suggest when manually triggered
                -- - "auto_menu": Show in completion menu automatically

                -- Virtual text settings (for inline mode)
                virtualtext = {
                    -- Auto-trigger in these modes
                    auto_trigger_ft = {
                        "lua",
                        "python",
                        "javascript",
                        "typescript",
                        "rust",
                        "go",
                        "c",
                        "cpp",
                        "sql",
                        "html",
                        "css",
                        "json",
                        "yaml",
                        "markdown",
                        "bash",
                        -- Add your languages
                    },
                    keymap = {
                        accept = "<A-y>",     -- Accept full suggestion
                        accept_line = "<A-l>", -- Accept one line
                        next = "<A-]>",        -- Next suggestion
                        prev = "<A-[>",        -- Previous suggestion
                        dismiss = "<A-e>",     -- Dismiss suggestion
                    },
                },
            })

            -- Optional: Add keybindings for manual triggering
            vim.keymap.set("i", "<C-Space>", function()
                require("minuet").trigger_completion()
            end, { desc = "Trigger AI completion" })
        end,
    },

    -- ==========================================================================
    -- OPTIONAL: Integration with blink.cmp
    -- ==========================================================================
    -- If you use blink.cmp, this integrates minuet as a source
    {
        "saghen/blink.cmp",
        optional = true,
        dependencies = {
            "milanglacier/minuet-ai.nvim",
        },
        opts = {
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "minuet" },
                providers = {
                    minuet = {
                        name = "minuet",
                        module = "minuet.blink",
                        score_offset = 8, -- Tune this to control priority vs other sources
                    },
                },
            },
        },
    },
}

-- ============================================================================
-- RECOMMENDED WORKFLOW
-- ============================================================================
--[[

COMPLETION MODES WITH BLINK.CMP:

minuet-ai.nvim works seamlessly with blink.cmp in two ways:

1. INLINE MODE (Default - Ghost Text):
   - AI suggestions appear as gray ghost text
   - Accept with Tab (or your configured accept key)
   - This is INDEPENDENT of blink.cmp menu
   - Best for: Fast, unobtrusive completions

2. COMPLETION MENU MODE (via blink.cmp integration):
   - AI suggestions appear IN the blink.cmp menu
   - Navigate with Ctrl-n/Ctrl-p (or your keys)
   - Appears alongside LSP, snippets, etc.
   - Best for: Seeing all options together

You can use BOTH at the same time! The blink integration is configured below.

DAILY USAGE:

1. PASSIVE TAB COMPLETE (minuet inline):
   - Just type code
   - Suggestions appear as ghost text
   - Press Tab to accept full suggestion
   - Press Ctrl+n to accept just the next line
   - Press Ctrl+y to accept just the next word

2. ACTIVE AI OPERATIONS (99):
   a) Refactoring:
      - Visual select the code block
      - Press <leader>ai
      - Type: "refactor this to use early returns"
      - AI modifies the selected code

   b) Adding boilerplate:
      - Select a TODO comment or function signature
      - Press <leader>ai
      - Type: "implement this with error handling"
      - AI fills in the code

   c) Code explanation/review:
      - Select confusing code
      - Press <leader>ai
      - Type: "explain what this does and suggest improvements"

3. CHAT/THINKING (Claude Code - separate):
   - Open terminal, run: claude-code
   - Use for: architecture questions, debugging help, research

]] --

-- ============================================================================
-- OLLAMA MODEL RECOMMENDATIONS
-- ============================================================================
--[[

Based on your RAM:

8GB RAM:
  ollama pull qwen2.5-coder:1.5b  # Surprisingly good for completion

16GB RAM:
  ollama pull qwen2.5-coder:7b    # Best balance (RECOMMENDED)

32GB+ RAM:
  ollama pull qwen2.5-coder:14b   # Even better, if you have the RAM
  ollama pull deepseek-coder-v2:16b  # Alternative

Test different models:
  ollama pull codellama:7b        # Alternative option
  ollama pull starcoder2:7b       # Another alternative

NOTE: Larger models = better quality but slower completions
      7B is the sweet spot for most people

]] --

-- ============================================================================
-- TROUBLESHOOTING
-- ============================================================================
--[[

1. Completions not appearing:
   - Check Ollama is running: ollama list
   - Check model is pulled: ollama list
   - Start Ollama server: ollama serve
   - Check logs: :lua require("minuet").get_status()

2. Completions too slow:
   - Use smaller model (1.5b or 3b)
   - Reduce context size in config
   - Increase throttle time

3. 99 not working:
   - Check Claude Code is installed: claude-code --version
   - Check logs: <leader>al
   - Ensure you're using visual mode for <leader>ai

4. Want to disable temporarily:
   - Minuet: :lua require("minuet").disable()
   - 99: <leader>ax (stops current requests)

]] --

