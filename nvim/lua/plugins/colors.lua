return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        -- 可選：如果你想改 palette
      end,
      on_highlights = function(hl, c)
        --  Visual
        hl.Visual = { bg = "#3d59a1" }

        --  Illuminate
        hl.IlluminatedWordText = { bg = "#545c8c", underline = true }
        hl.IlluminatedWordRead = { bg = "#545c8c", underline = true }
        hl.IlluminatedWordWrite = { bg = "#545c8c", underline = true }
      end,
    },
  },
}
