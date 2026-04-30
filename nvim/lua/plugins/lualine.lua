return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            opts.winbar = {
                lualine_c = {
                    {
                        "navic",
                        always_visible = true,
                        draw_empty = true,
                    },
                },
            }

            opts.inactive_winbar = opts.winbar
        end,
    },
}
