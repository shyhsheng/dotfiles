return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "robot" })

            vim.api.nvim_create_autocmd("User", {
                pattern = "TSUpdate",
                callback = function()
                    require("nvim-treesitter.parsers").robot = {
                        install_info = {
                            url = "https://github.com/Hubro/tree-sitter-robot",
                            files = { "src/parser.c" },
                            branch = "master",
                            queries = "queries",
                        },
                    }
                end,
            })

            vim.filetype.add({
                extension = {
                    robot = "robot",
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "robot",
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end,
    },
}
