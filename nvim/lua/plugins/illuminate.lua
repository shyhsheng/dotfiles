-- ~/.config/nvim/lua/plugins/illuminate.lua
return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        delay = 200,
        under_cursor = true,
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
      })
    end,
  },
}
