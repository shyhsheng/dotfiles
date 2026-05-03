-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            vim.schedule(function()
                -- back to dashboard / startup buffer
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local ft = vim.bo[buf].filetype

                    if ft == "snacks_dashboard" or ft == "dashboard" or ft == "alpha" then
                        vim.api.nvim_set_current_win(win)
                        return
                    end
                end
            end)
        end
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "PersistenceLoadPost",
    callback = function()
        -- 1. find the first listed buffer
        local first_buf = nil

        for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1  })) do
            first_buf = buf.bufnr
            break
        end

        -- 2. If the first buffer is snacks explorer/picker，delete it.
        if first_buf and vim.api.nvim_buf_is_valid(first_buf) then
            pcall(vim.api.nvim_buf_delete, first_buf, { force = true })
        end

        -- 3. focus on editor
        vim.schedule(function()
            pcall(function()
                require("snacks").explorer({
                    cwd = LazyVim.root(),
                    enter = false,
                })
            end)
        end)
    end,
})
