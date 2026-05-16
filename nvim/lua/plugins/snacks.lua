return {
    {
        "folke/snacks.nvim",
        keys = {
            -- 先 disable 原本的
            { "<leader>ff", false },
            { "<leader>fF", false },
            { "<leader>sg", false },
            { "<leader>sG", false },
            { "<leader>sw", false },
            { "<leader>sW", false },
            { "<leader><space>", false },

            -- 重新綁定（交換）
            { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
            { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
            { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)"},
            { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
            { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
            { "<leader>sw", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
            { "<leader>sW", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
        },
        opts = {
            picker = {
                sources = {
                    explorer = {
                        actions = {
                            yank_filename = function(_, item)
                                if not item or not item.file then
                                    return
                                end
                                local name = vim.fs.basename(item.file)
                                vim.fn.setreg("+", name)
                                vim.fn.setreg('"', name)
                                vim.notify("Yanked filename: " .. name)
                            end,
                            yank_fullpath = function(_, item)
                                if not item or not item.file then
                                    return
                                end

                                vim.fn.setreg("+", item.file)
                                vim.fn.setreg('"', item.file)
                                vim.notify("Yanked full path: " .. item.file)
                            end,
                            yank_filename_without_ext = function(_, item)
                                if not item or not item.file then
                                    return
                                end

                                local name = vim.fs.basename(item.file)
                                local name_without_ext = vim.fn.fnamemodify(name, ":r")

                                vim.fn.setreg("+", name_without_ext)
                                vim.fn.setreg('"', name_without_ext)
                                vim.notify("Yanked filename without extension: " .. name_without_ext)
                            end,
                        },
                        win = {
                            list = {
                                keys = {
                                    ["y"] = "yank_filename",
                                    ["Y"] = "yank_fullpath",
                                    ["gy"] = "yank_filename_without_ext",
                                    ["<Esc>"] = false,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
