-- ==========================================================================
-- QUICK AI OPERATIONS: 99 with Claude Code
-- ==========================================================================
return {
    "ThePrimeagen/99",
    config = function()
        local _99 = require("99")

        _99.setup({
            -- Use Claude Code as the provider
            provider = _99.Providers.ClaudeCodeProvider,

            -- Optional: Override the model (defaults to Claude's default)
            -- model = "claude-sonnet-4-20250514",

            -- Logging (useful for debugging)
            logger = {
                level = _99.INFO, -- Change to DEBUG if you have issues
                path = "/tmp/99.log",
                print_on_error = true,
            },

            -- Completions for #rules and @files in prompt
            completion = {
                custom_rules = {},

                -- Optional: Path to your cursor rules
                -- cursor_rules = vim.fn.expand("~/.cursor/rules"),

                -- Project-specific AGENT.md files
                -- These define context/rules for AI in your projects
                md_files = {
                    "AGENT.md",
                    ".ai/AGENT.md",
                },
            },
        })

        -- =======================================================================
        -- KEYBINDINGS
        -- =======================================================================

        -- Main keybinding: Visual select code, then prompt AI
        -- Example use cases:
        --   - Select function, "<leader>ai", "add error handling"
        --   - Select code, "<leader>ai", "refactor this to be more idiomatic"
        --   - Select TODO comment, "<leader>ai", "implement this"
        vim.keymap.set("v", "<leader>ai", function()
            _99.visual()
        end, { desc = "AI: Refactor/modify selected code" })

        -- Search through codebase with AI context
        vim.keymap.set("n", "<leader>as", function()
            _99.search()
        end, { desc = "AI: Search with context" })

        -- Cancel all running requests
        vim.keymap.set("n", "<leader>ax", function()
            _99.stop_all_requests()
        end, { desc = "AI: Stop all requests" })

        -- View logs (useful for debugging)
        vim.keymap.set("n", "<leader>al", function()
            _99.view_logs()
        end, { desc = "AI: View logs" })
    end,
}

-- ============================================================================
-- ADVANCED: Create AGENT.md for project-specific context
-- ============================================================================
--[[

Create a file called AGENT.md in your project root:

```markdown
# Project: MyApp

## Tech Stack
- Python 3.11
- FastAPI
- PostgreSQL with SQLAlchemy
- pytest for testing

## Code Style
- Use type hints everywhere
- Prefer dataclasses over dicts
- All functions need docstrings
- Maximum line length: 88 (black)

## Common Patterns
- All API endpoints use dependency injection
- Database models in models/
- Business logic in services/
- Always include error handling

## Testing Requirements
- All new functions need unit tests
- Use factories for test data
- Mock external services
```

Then 99 will automatically use this context when making changes!

]] --
