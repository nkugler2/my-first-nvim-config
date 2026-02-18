-------------------------------- Statusline ------------------------------------
-- Custom statusline configuration with two helper functions:
--   venv()       — displays the active Python virtual environment name
--   short_path() — displays a shortened, cwd-relative file/directory path


-- venv() — Show the active Python virtual environment in the statusline.
-- Reads the VIRTUAL_ENV environment variable and extracts just the folder name.
-- Returns "(env_name)" when a venv is active, or "" when there is none.
function _G.venv()
    -- os.getenv returns nil if the variable is not set
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        -- fnamemodify with ":t" extracts the tail (last component) of the path,
        -- so "/home/noah/.venvs/myproject" becomes "myproject"
        return "(" .. vim.fn.fnamemodify(venv, ":t") .. ")"
    end
    return ""
end

-- short_path() — Build a compact path string for the statusline.
--
-- The goal is to show paths relative to the directory you launched nvim from (cwd),
-- prefixed with a leading slash and the cwd folder name. This keeps the statusline
-- short while still telling you where you are.
--
-- Examples (assuming cwd is ~/.config/nvim):
--   netrw at cwd root        → /nvim
--   netrw in lua/noah/        → /nvim/lua/noah
--   editing a file             → /nvim/lua/noah/options.lua
--   file outside cwd           → ~/other/project/file.lua  (fallback)
--   empty buffer               → [No Name]
function _G.short_path()
    -- pcall wraps the whole function so that any unexpected error
    -- (e.g. a nil value) doesn't break the statusline; we handle
    -- failures in the fallback below.
    local ok, result = pcall(function()
        ---------- netrw (directory browser) buffers ----------
        if vim.bo.filetype == "netrw" then
            -- vim.b.netrw_curdir is a buffer-local variable that netrw sets to the
            -- directory it is currently displaying. It may not exist yet on the very
            -- first render, so we fall back to the buffer's file path or cwd.
            local dir = vim.b.netrw_curdir
                or vim.fn.expand("%:p")
                or vim.fn.getcwd()

            -- vim.fn.getcwd() returns the working directory nvim was started in
            local cwd = vim.fn.getcwd()

            -- ":t" gives us just the last folder name (the "tail")
            -- e.g. "/Users/noah/.config/nvim" → "nvim"
            local cwd_name = vim.fn.fnamemodify(cwd, ":t")

            if dir == cwd or dir == cwd .. "/" then
                -- We are at the cwd root, so just show "/nvim"
                return "/" .. cwd_name
            elseif dir:sub(1, #cwd + 1) == cwd .. "/" then
                -- We are in a subdirectory of cwd.
                -- dir:sub(#cwd + 1) strips the cwd prefix, leaving e.g. "/lua/noah"
                -- so the result becomes "/nvim/lua/noah"
                return "/" .. cwd_name .. dir:sub(#cwd + 1)
            end

            -- If the directory is completely outside cwd (rare), show the full path
            -- relative to the home directory, e.g. "~/Downloads"
            return vim.fn.fnamemodify(dir, ":~")
        end

        ---------- regular file buffers ----------

        -- expand("%:p") gives the full absolute path of the current buffer
        local fullpath = vim.fn.expand("%:p")

        -- handle unnamed / empty buffers
        if fullpath == "" then
            return "[No Name]"
        end

        local cwd = vim.fn.getcwd()

        -- check if the file lives under cwd
        if fullpath:sub(1, #cwd + 1) == cwd .. "/" then
            -- strip the cwd prefix and prepend "/cwd_name"
            -- e.g. "/Users/noah/.config/nvim/lua/noah/options.lua"
            --    → "/nvim/lua/noah/options.lua"
            local cwd_name = vim.fn.fnamemodify(cwd, ":t")
            return "/" .. cwd_name .. fullpath:sub(#cwd + 1)
        end

        -- file is outside cwd — show full path from home
        -- ":~" replaces the home directory prefix with "~"
        return vim.fn.fnamemodify(fullpath, ":~")
    end)

    if ok then
        return result
    else
        -- if anything inside pcall errored, fall back to neovim's built-in
        -- path shortening: ":~" replaces home with "~", ":." makes it
        -- relative to cwd — a safe default that always works.
        return vim.fn.expand("%:~:.")
    end
end

-------------- statusline format string ----------------------------------------
-- Each %#HighlightGroup# ... %* pair colors a section, then resets to default.
--
--   %{v:lua.short_path()}  — call our short_path() function above
--   %m                     — modified flag: [+] when buffer has unsaved changes
--   %q                     — quickfix / location list label (if applicable)
--   %r                     — read-only flag: [RO]
--   %h                     — help buffer flag: [help]
--   %w                     — preview window flag: [Preview]
--   %=                     — separation point: everything after this is right-aligned
--   %{v:lua.venv()}        — call our venv() function above
--   %y                     — filetype in brackets, e.g. [lua]

vim.o.statusline =
"%{v:lua.short_path()}%* %#PmenuSel#%m%* %#WarningMsg#%q%* %#ErrorMsg#%r%* %#WarningMsg#%h%* %#statusline#%w%* %= %{v:lua.venv()} %y %l:%c/%L"
