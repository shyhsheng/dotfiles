-- return {
--     "lfv89/vim-interestingwords",
--     --event = "VeryLazy",
--     lazy = false,
--     config = function()
--     end,
-- }

return {
    "Mr-LLLLL/interestingwords.nvim",
    event = "VeryLazy",
    config = function()
        require("interestingwords").setup {
            colors = {
                '#9ece6a', -- green (success / normal)
                '#e0af68', -- yellow (warning)
                '#7aa2f7', -- blue (info)
                '#bb9af7', -- purple (secondary)
                '#2ac3de', -- cyan (highlight)
                '#f7768e' -- red-pink (critical)
            },
            -- colors = {
            --   '#00ff00', -- neon green
            --   '#ffff00', -- neon yellow
            --   '#00ffff', -- cyan
            --   '#ff00ff', -- magenta
            --   '#ff8800', -- orange
            --   '#ff0055', -- strong red
            -- }
            search_count = true,
            navigation = false,
            scroll_center = true,
            search_key = "<leader>m",
            cancel_search_key = "<leader>M",
            color_key = "<leader>k",
            cancel_color_key = "<leader>K",
            select_mode = "loop",  -- random or loop
        }
    end,
}
