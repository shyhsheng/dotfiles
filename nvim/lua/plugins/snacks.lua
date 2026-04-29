return {
    {
        "folke/snacks.nvim",
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
